require_relative 'scheduler/processor'

class Main
  attr_accessor :tasks
  def initialize
    @tasks = []
  end

  def start
    processor = Scheduler::Processor.new

    input = ''

    puts "Hi, I'm your personal assistant. Type 'help me' to see what I can do!"
    while input.strip != 'exit'
      print "> "
      input = gets
      print_help and return if input.strip === 'help' || input.strip === 'help me'
      processor.process(input)
    end
  end

  def print_help
    puts "Ask me to remember something and I will."
    puts "eg. 'Go to the movies at 2pm tomorrow.'"
    puts ""
    puts "Type 'list' to see everything I'm remembering at the moment."
    puts "Type 'exit' to quit."
  end
end

m = Main.new
m.start
