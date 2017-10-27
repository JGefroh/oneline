module Core
  module Plugin
    @@plugins = {}

    def load(plugin)
      Core::Plugin.plugins[plugin.class] = plugin
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
      return Core::PluginResponse.new(result)
    end

    def self.call_all(data, params = {})
      plugin_responses = []

      Core::Plugin.plugins.each { |key, plugin|
        plugin_response = plugin.call(data, params)
        plugin_responses << plugin_response if plugin_response
      }

      return plugin_responses
    end

    def self.plugins
      return @@plugins
    end
  end
end
