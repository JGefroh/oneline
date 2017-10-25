require_relative 'parser'
require_relative 'interpreter'
require_relative 'console_renderer'
require_relative 'scheduled_item'

module Scheduler
  class Processor
    attr_accessor :tasks
    attr_accessor :renderer
    attr_accessor :parser
    attr_accessor :interpreter

    def initialize()
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

      if interpreted_data[:interpreted]
        item = to_scheduled_item(interpreted_data)
        @tasks << item
        @renderer.render(:on_create, item)
      end

      return item
    end

    def process?(text)
      return true
    end

    def to_scheduled_item(interpreted_data)
      s = Scheduler::ScheduledItem.new(interpreted_data)
      return s
    end
  end
end
