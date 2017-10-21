require_relative 'scheduler/processor'

tasks = []
processor = Scheduler::Processor.new

input = nil

while input != 'exit'
  input = gets
  task = processor.process(input)
  if task[:interpreted]
    tasks << task
    puts tasks
  end
end
