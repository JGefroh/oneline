require './core/store'
require './core/plugin'
require_relative 'processor'
module Scheduler
  class Plugin
    include OneLine::Plugin
    attr_accessor :processor

    def initialize
      @processor = Scheduler::Processor.new()
      initialize_help_messages()
      load(self)
    end

    def process(data)
      item = processor.process(data)
      add_to_notification_queue(item) if item
    end

    def process?(data)
      return processor.process?(data)
    end

    private def add_to_notification_queue(item)
      notification_queue = OneLine::Store.data["Notifications::Plugin-queue"] || []
      notification_queue << item if notification_queue
    end

    private def initialize_help_messages
      OneLine::Store.data["#{self.class}-help"] = [
        "I'll remember things with times or dates in them.",
        "Try typing `go to the movies in 15 minutes` or `call friend at 2:35pm`!",
        "You can type `list` to see what I've remembered for you.",
      ]
    end
  end
end
Scheduler::Plugin.new
