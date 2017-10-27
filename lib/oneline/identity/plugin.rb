module Plugins
  module Identity
    class Plugin
      include Core::Plugin

      def initialize(tasks = {})
        @processor = Identity::Processor.new
        load(self)
      end

      def process(text, params = {})
        return @processor.process(text, params)
      end

      def process?(text, params = {})
        return @processor.process?(text, params)
      end
    end
  end
end
