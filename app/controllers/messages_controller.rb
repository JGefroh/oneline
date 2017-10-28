class MessagesController < ApplicationController
  around_action :set_time_zone

  def set_time_zone
    owner_id = params[:owner_id] || params[:From] || params['From']
    if !owner_id.nil? && owner_id.length > 0
      user_time_zone = User.find_or_create_by(user_identifier: owner_id).time_zone
      user_time_zone = Time.zone unless ActiveSupport::TimeZone[user_time_zone].present?
      Time.use_zone(user_time_zone || Time.zone) {
        puts "User TZ: #{user_time_zone}. Actual TZ: #{Time.zone}. Request time: #{Time.zone}"
        yield
      }
    else
      yield
    end
  end

  def create
    handler = Server::IncomingWebHandler.new()
    responses = handler.handle(params)
    render json: responses
  end

  def sms
    handler = Server::IncomingSmsHandler.new()
    responses = handler.handle(params)
    render json: {}
  end
end
