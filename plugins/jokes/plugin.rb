require './core/plugin'
require './core/store'
require './utilities/requestor'
require_relative 'console_renderer'
require_relative 'joke'
module Jokes
  class Plugin
    include OneLine::Plugin

    def initialize
      load(self)
      @renderer = Jokes::ConsoleRenderer.new
    end

    def load(plugin)
      super(plugin)
    end

    def process(text)
      r = Requestor.new('icanhazdadjoke.com', true, {"User-Agent": "OneLine (https://github.com/JGefroh/oneline)"})
      joke_json = r.query_as_json()
      joke = to_joke(joke_json)
      @renderer.render(joke)
    end

    def process?(text)
      return text === 'tell me a joke'
    end

    def to_joke(joke)
      return Jokes::Joke.new(joke)
    end
  end
end
Jokes::Plugin.new
