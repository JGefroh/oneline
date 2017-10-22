require_relative 'parser'
require_relative 'interpreter'
require_relative 'console_renderer'

module Scheduler
  class Processor
    attr_accessor :tasks
    attr_accessor :renderer
    attr_accessor :parser
    attr_accessor :interpreter

    def initialize
      @parser = Scheduler::Parser.new
      @renderer = Scheduler::ConsoleRenderer.new
      @interpreter = Scheduler::Interpreter.new
      @tasks = []
    end

    def process(text)
      @renderer.render(:on_list_request, @tasks) and return if text.chomp === 'list'

      parsed_text = parser.parse(text)
      interpreted_data = interpreter.interpret(parsed_text)
      interpreted_data[:original_text] = text

      #TODO: Create a notification request.
      #TODO: Save to a schedule or appropriate list.

      if interpreted_data[:interpreted]
        @tasks << interpreted_data
        @renderer.render(:on_create, interpreted_data)
      end

      return interpreted_data
    end
  end
end
