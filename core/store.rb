module OneLine
  class Store
    @@plugins = {}
    @@global_data = {}
    @@segmented_data = {}

    def self.global_data
      return @@global_data
    end

    def self.data_for(key)
      @@segmented_data[key] = @@segmented_data[key] || {}
      return @@segmented_data[key]
    end

    def self.plugins
      return @@plugins
    end
  end
end
