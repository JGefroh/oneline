module OneLine
  class Store
    @@plugins = {}
    @@data = {}

    def self.data
      return @@data
    end

    def self.plugins
      return @@plugins
    end
  end
end
