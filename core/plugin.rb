require_relative 'store'
module OneLine
  module Plugin
    def load(plugin)
      OneLine::Store.plugins[plugin.class] = plugin
      puts "Loaded #{plugin.class}"
    end

    def process?(data)
      return false
    end

    def process(data)
    end
  end
end
