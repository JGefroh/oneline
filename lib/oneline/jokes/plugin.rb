module Jokes
  class Plugin
    include Core::Plugin

    def initialize
      @processor = Jokes::Processor.new
      puts 'hello'
      load(self)
    end

    def process(text, params = {})
      return @processor.process(text)
    end

    def process?(text, params = {})
      return @processor.process?(text) if text
    end
  end
  ::Jokes::Plugin.new()
end
