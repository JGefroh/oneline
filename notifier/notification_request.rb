require_relative 'notififer'
module Notifier
  class NotificationJob
    def process(params)
      n = Notifier.new
      n.notify(params[:target], params[:message], :sms)
    end
  end
end
