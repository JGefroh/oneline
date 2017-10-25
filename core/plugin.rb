require_relative 'store'
module OneLine
  module Plugin
    def load(plugin)
      puts "Loaded #{plugin.class}"
      OneLine::Store.plugins << plugin
    end

    def process?(data)
      return false
    end

    def process(data)
    end
  end
end
