require_relative 'scheduler/processor'


processor = Scheduler::Processor.new
puts processor.process('Get coffee at 3pm friday')
