require './core/store'
require './core/plugin'
require_relative 'processor'
module Scheduler
  class Plugin
    include OneLine::Plugin
    attr_accessor :processor

    def initialize
      load(self)
    end

    def load(plugin)
      super(plugin)
      @processor = Scheduler::Processor.new(OneLine::Store.data)
    end

    def process(data)
      return processor.process(data)
    end

    def process?(data)
      return processor.process?(data)
    end
  end
end
Scheduler::Plugin.new
