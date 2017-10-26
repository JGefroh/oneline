require './plugins/notifications/notifiable'
require 'date'
require 'time'
module Scheduler
  class ScheduledItem
    include Notifications::Notifiable
    attr_accessor :label
    attr_accessor :date
    attr_accessor :time
    attr_accessor :original_text
    attr_accessor :created_at

    def initialize(params = {})
      @label = params[:label]
      @date = params[:date]
      @time = params[:time]
      @notify_at_date = @date
      @notify_at_time = @time
      @original_text = params[:original_text]
      @created_at = DateTime.now
    end
  end
end
