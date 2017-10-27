module Jokes
  module Gateways
    class IcanhazdadjokeGateway < Jokes::JokeGateway
      def query_api
        r = Utilities::Requestor.new('icanhazdadjoke.com', true, {"User-Agent": "OneLine (https://github.com/JGefroh/oneline)"})
        return r.query_as_json
      end
    end
  end
end
