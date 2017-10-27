module Server
  class IncomingWebHandler
    def handle(payload)
      return [] if payload[:owner_id].length <= 20
      plugin_responses = Core::Plugin.call_all(payload[:message], {owner_id: payload[:owner_id]})
      return convert_to_message_hashes(plugin_responses)
    end

    private def convert_to_message_hashes(plugin_responses)
      response_messages = []
      plugin_responses.each{ |plugin_response|
        plugin_response.messages.each{|message|
          response_messages << {message: message}
        }
      }
      return response_messages
    end

    def to_json(body)
      return JSON.parse(body.read.to_s) rescue nil
    end
  end
end
