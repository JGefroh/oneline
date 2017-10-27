require './core/plugin'
require './core/store'
require_relative 'worker'
module Notifications
  class Plugin
    include OneLine::Plugin
    def initialize()
      notification_queue = []
      OneLine::Store.global_data["#{self.class}-queue"] = notification_queue
      worker = Notifications::Worker.new(notification_queue)
      worker.start()
      OneLine::Store.global_data["#{self.class}-help"] = [
        "I'll notify you via SMS / text when one of your reminders approaches."
      ]
      load(self)
    end
  end
end
Notifications::Plugin.new
