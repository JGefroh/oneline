require './core/store'
require './core/plugin'
require './plugins/notifications/notifiers/plivo_notifier'
require 'plivo'

module OneLine
  module Server
    class IncomingSmsHandler
      def handle(request)
        verify_source(request)
        plugin_responses = OneLine::Plugin.call_all(request.params[:Text] || request.params['Text'], {owner_id: request.params[:From] || request.params['From']})
        send_plugin_responses_as_texts(plugin_responses, request.params[:From] || request.params['From'])
        return true
      end

      private def verify_source(request)
        raise 'unauthorized' unless request.params['key'] && request.params['key'] === ENV['SMS_WEBHOOK_KEY']
      end

      private def send_plugin_responses_as_texts(plugin_responses, target_phone_number)
        plivo = Notifications::PlivoNotifier.new
        plugin_responses.each{ |plugin_response|
          plugin_response.messages.each{|message|
            plivo.notify(target_phone_number, message)
          }
        }
      end
    end
  end
end
