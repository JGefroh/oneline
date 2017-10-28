module Notifications
  module Notifiers
    class PlivoNotifier
      include ::Notifications::Notifier
      def notify(target, message, params = {})
        plivo = Plivo::RestAPI.new(ENV['PLIVO_AUTH_ID'], ENV['PLIVO_AUTH_TOKEN'])
        plivo.send_message({
          src: ENV['PLIVO_SOURCE_NUMBER'],
          dst: target,
          text: message
        })
      end
    end
  end
end
