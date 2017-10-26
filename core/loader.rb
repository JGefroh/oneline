require 'find'
module OneLine
  class Loader
    def self.load(regex)
      Find.find('./') do |path|
        if path =~ regex
          if path != File.expand_path(File.dirname(__FILE__))
            require "#{path}"
          end
        end
      end
    end
  end
end
