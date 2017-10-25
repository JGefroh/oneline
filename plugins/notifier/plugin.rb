require './core/plugin'
require './core/store'
require_relative 'worker'
module Notifier
  class Plugin
    include OneLine::Plugin
    def initialize()
      load(self)
      worker = Notifier::Worker.new(OneLine::Store.data)
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
