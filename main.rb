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
      task = processor.process(input)

      print_list if input.strip === 'list'
      print_help if input.strip === 'help' || input.strip === 'help me'

      if task[:interpreted]
        @tasks << task
        puts "----- Great! I'll remind you to `#{task[:label]}` on #{task[:date]} at #{task[:time].strftime('%l:%M %P').strip}." if !task[:date].nil? && !task[:time].nil?
        puts "----- Great! I'll remind you to `#{task[:label]}` on #{task[:date]}." if !task[:date].nil? && task[:time].nil?
        puts "----- Great! I'll remind you to `#{task[:label]}` today at #{task[:time].strftime('%l:%M %P').strip}." if task[:date].nil? && !task[:time].nil?
      end
    end
  end

  def print_help
    puts "Ask me to remember something and I will."
    puts "eg. 'Go to the movies at 2pm tomorrow.'"
    puts ""
    puts "Type 'list' to see everything I'm remembering at the moment."
    puts "Type 'exit' to quit."
  end

  def print_list
    puts "----- Your list..\n"
    @tasks.each{ |task| puts "----- * #{task[:original_text]}"}
  end
end

m = Main.new
m.start
