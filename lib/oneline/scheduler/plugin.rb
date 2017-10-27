module Scheduler
  class Plugin
    include Core::Plugin
    attr_accessor :processor

    def initialize
      @processor = Scheduler::Processor.new()
      load(self)
    end

    def process(text, params = {})
      result = @processor.process(text, params[:owner_id])

      if result && result[:data]
        result[:data].owner_id = params[:owner_id]
        add_to_notification_queue(result[:data])
      end

      return result
    end

    def process?(text, params = {})
      return @processor.process?(text) if text
    end

    private def add_to_notification_queue(item)
      notification_queue = []
      notification_queue << item if notification_queue
    end
  end
  ::Scheduler::Plugin.new
end
