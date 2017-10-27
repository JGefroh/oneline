require './core/store'
require './core/plugin'

module OneLine
  module Server
    class IncomingWebHandler
      def handle(request)
        request_payload = to_json(request.body)
        return [] unless request_payload
        plugin_responses = OneLine::Plugin.call_all(request_payload['message'], {owner_id: request.params[:owner_id]})
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
end
