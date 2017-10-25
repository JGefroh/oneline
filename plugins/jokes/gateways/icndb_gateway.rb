require_relative '../joke_gateway'
module Jokes
  class IcndbGateway < Jokes::JokeGateway
    def query_api
      r = Requestor.new('api.icndb.com', false, {"User-Agent": "OneLine (https://github.com/JGefroh/oneline)"})
      return r.query_as_json('/jokes/random')
    end

    def to_joke(joke_json)
      return Jokes::Joke.new(joke: joke_json['value']['joke'])
    end
  end
end
