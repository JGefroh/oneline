require './core/plugin'
require './core/store'
require_relative 'worker'
module Notifier
  class Plugin
    include OneLine::Plugin
    def initialize()
      notification_queue = []
      OneLine::Store.data["#{self.class}-queue"] = notification_queue
      worker = Notifier::Worker.new(notification_queue)
      worker.start()
      OneLine::Store.data["#{self.class}-help"] = [
        "I'll notify you via SMS / text when one of your reminders approaches."
      ]
      load(self)
    end
  end
end
Notifier::Plugin.new
