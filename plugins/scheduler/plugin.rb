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
      @processor = Scheduler::Processor.new()
    end

    def process(data)
      item = processor.process(data)
      add_to_notification_queue(item) if item
    end

    def process?(data)
      return processor.process?(data)
    end

    private def add_to_notification_queue(item)
      notification_queue = OneLine::Store.data["Notifier::Plugin-queue"] || []
      notification_queue << item if notification_queue
    end
  end
end
Scheduler::Plugin.new
