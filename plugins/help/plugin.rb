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

    def process(text)
      print_help()
    end

    def process?(text)
      return text === 'help' || text === 'help me'
    end

    def print_help
      OneLine::Store.data.each{|key, value|
        if key.include?('help')
          puts value
          puts ""
        end
      }

      puts "Type 'exit' to quit."
    end
  end
end
Help::Plugin.new
