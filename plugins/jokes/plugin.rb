require './core/plugin'
require './core/store'
require_relative 'processor'
module Jokes
  class Plugin
    include OneLine::Plugin

    def initialize
      @processor = Jokes::Processor.new
      load(self)
    end

    def load(plugin)
      super(plugin)
    end

    def process(text)
      return @processor.process(text)
    end

    def process?(text)
      return @processor.process?(text)
    end
  end
end
Jokes::Plugin.new
