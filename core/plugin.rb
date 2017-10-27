require_relative 'store'
require_relative 'plugin_response'
module OneLine
  module Plugin
    def load(plugin)
      OneLine::Store.plugins[plugin.class] = plugin
      puts "Loaded #{plugin.class}"
    end

    def call(data, params = {})
      if process?(data, params)
        result = process(data, params)
        to_response(result) if result
      end
    end

    def process?(data, params = {})
      return false
    end

    def process(data, params = {})
    end

    def to_response(result)
      return OneLine::PluginResponse.new(result)
    end
  end
end
