require_relative 'parser'
require_relative 'interpreter'

module Scheduler
  class Processor
    def process(text)
      parser = Scheduler::Parser.new
      parsed_text = parser.parse(text)

      interpreter = Scheduler::Interpreter.new
      interpreted_data = interpreter.interpret(parsed_text)

      interpreted_data[:original_text] = text
      
      return interpreted_data
    end
  end
end
