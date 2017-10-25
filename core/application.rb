module OneLine
  class Application
    def initialize
      start()
    end
    
    def start
      input = ''
      puts "Hi, I'm your personal assistant. Type 'help me' to see what I can do!"
      while input.strip != 'exit'
        print "> "
        input = gets
        input = input.strip
        OneLine::Store.plugins.each { |plugin| plugin.process(input) if plugin.process?(input) }
      end
    end
  end
  o = OneLine::Application.new
end
