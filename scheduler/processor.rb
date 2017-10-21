module Scheduler
  class Processor
    def process(text)
      parser = Scheduler::Parser.new
      parsed_text = parser.parse(text)

      interpreter = Scheduler::Interpreter.new
      interpreted_data = interpreter.interpret(text)
    end
  end
end
