require './core/plugin'
require './core/store'
module Help
  class Plugin
    include OneLine::Plugin

    def initialize
      load(self)
    end

    def load(plugin)
      super(plugin)
    end

    def process(text, params = {})
      return {messages: render_help()}
    end

    def process?(text, params = {})
      return text === 'help' || text === 'help me'
    end

    def render_help
      messages = []
      OneLine::Store.global_data.each{|key, value|
        if key.include?('help')
          value.each{|message| messages << message}
        end
      }
      return messages
    end
  end
end
Help::Plugin.new
