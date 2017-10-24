require_relative 'help/processor'
require_relative 'scheduler/processor'
require_relative 'notifier/worker'
class Main
  attr_accessor :tasks
  attr_accessor :processors

  def initialize
    @tasks = []
    @processors = []
  end

  def start
    @processors << Scheduler::Processor.new(@tasks)
    @processors << Help::Processor.new()
    worker = Notifier::Worker.new([])

    worker.start()

    input = ''
    puts "Hi, I'm your personal assistant. Type 'help me' to see what I can do!"
    while input.strip != 'exit'
      print "> "
      input = gets
      input = input.strip
      @processors.each { |processor| processor.process(input) if processor.process?(input) }
    end
  end
end

m = Main.new
m.start
