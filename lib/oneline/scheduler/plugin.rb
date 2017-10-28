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
      return result
    end

    def process?(text, params = {})
      return @processor.process?(text) if text
    end
  end
  ::Scheduler::Plugin.new
end
