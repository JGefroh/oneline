require './core/plugin'
require './core/store'
require_relative 'processor'
module Jokes
  class Plugin
    include OneLine::Plugin

    def initialize
      @processor = Jokes::Processor.new
      initialize_help_messages()
      load(self)
    end

    def process(text)
      return @processor.process(text)
    end

    def process?(text)
      return @processor.process?(text)
    end

    def initialize_help_messages()
      OneLine::Store.data["#{self.class}-help"] = [
        "Try saying `tell me a dad joke` to hear some great humor!\n",
        "Currently I know dad jokes and chuck norris jokes."
      ]
    end
  end
end
Jokes::Plugin.new
