class MessagesController < ApplicationController
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
