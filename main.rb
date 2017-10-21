require_relative 'scheduler/processor'

tasks = []
processor = Scheduler::Processor.new

input = nil

while input != 'exit'
  input = gets
  task = processor.process(input)
  puts task
  
  if task[:interpreted]
    tasks << task
    puts "Your list.."
    tasks.each{ |task| puts "* #{task[:original_text]}"}
  end
end
