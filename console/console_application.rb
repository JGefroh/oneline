module OneLine
  class ConsoleApplication
    def initialize
      initialize_interrupt_handler()
      start()
    end

    private def initialize_interrupt_handler
      trap "SIGINT" do
        puts "Type `exit` to quit."
      end
    end

    def start
      input = ''
      puts "Hi, I'm your personal assistant. Type 'help me' to see what I can do!"
      while input.strip != 'exit'
        print "> "
        input = gets
        input = input.strip
        plugin_responses = OneLine::Plugin.call_all(input, {owner_id: 'static-self-owner-id'})
        print_message_hashes(plugin_responses)
      end
    end

    private def print_message_hashes(plugin_responses)
      response_messages = []
      plugin_responses.each{ |plugin_response|
        plugin_response.messages.each{|message|
          puts message
        }
      }
    end
  end
end
