require_relative 'store'
module OneLine
  module Plugin
    def load(plugin)
      puts "Loaded #{plugin.class}"
      OneLine::Store.plugins << plugin
    end

    def process?(data)
      raise 'unimplemented'
    end

    def process(data)
      raise 'unimplemented'
    end
  end
end
