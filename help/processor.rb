require_relative '../core/processor'

module Help
  class Processor
    include OneLine::Processor
    def process(text)
      print_help()
    end

    def process?(text)
      return text === 'help' || text === 'help me'
    end

    def print_help
      puts "Ask me to remember something and I will."
      puts "eg. 'Go to the movies at 2pm tomorrow.'"
      puts ""
      puts "Type 'list' to see everything I'm remembering at the moment."
      puts "Type 'exit' to quit."
    end
  end
end
