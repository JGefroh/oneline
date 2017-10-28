module Server
  class IncomingSmsHandler
    def handle(payload)
      verify_source(request)
      plugin_responses = Core::Plugin.call_all(payload[:Text] || payload['Text'], {owner_id: payload[:From] || payload['From']})
      send_plugin_responses_as_texts(plugin_responses, payload[:From] || payload['From'])
      return true
    end

    private def verify_source(request)
      raise 'unauthorized' unless payload['key'] && payload['key'] === ENV['SMS_WEBHOOK_KEY']
    end

    private def send_plugin_responses_as_texts(plugin_responses, target_phone_number)
      plivo = ::Notifications::Notifiers::PlivoNotifier.new
      plugin_responses.each{ |plugin_response|
        plugin_response.messages.each{|message|
          plivo.notify(target_phone_number, message)
        }
      }
    end
  end
end
