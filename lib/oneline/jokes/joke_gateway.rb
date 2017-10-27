module Jokes
  class JokeGateway
    def get_joke
      response_json = query_api()
      joke_json = response_json
      joke = to_joke(joke_json)
    end

    def query_api()
      raise 'unimplemented'
    end

    def to_joke(joke)
      return Jokes::Joke.new(joke)
    end
  end
end
