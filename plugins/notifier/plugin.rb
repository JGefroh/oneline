require './core/plugin'
require './core/store'
require_relative 'worker'
module Notifier
  class Plugin
    include OneLine::Plugin
    def initialize()
      load(self)
      notification_queue = []
      OneLine::Store.data["#{self.class}-queue"] = notification_queue
      worker = Notifier::Worker.new(notification_queue)
      worker.start()
    end

    def load(plugin)
      super(plugin)
    end

    def process?(data)
    end

    def process(data)
    end
  end
end
Notifier::Plugin.new
