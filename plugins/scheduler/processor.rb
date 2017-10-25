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

      unless text.scan(/^(remove \d+)$/i).empty?
        task = remove_task(text)
        @renderer.render(:on_remove, task)
        return task
      end

      task = add_task(text)
      @renderer.render(:on_create, task)

      return task
    end

    private def add_task(text)
      parsed_text = parser.parse(text)
      interpreted_data = interpreter.interpret(parsed_text)
      interpreted_data[:original_text] = text

      if interpreted_data[:interpreted]
        item = to_scheduled_item(interpreted_data)
        @tasks << item
      end

      return item
    end

    private def remove_task(text)
      task_index = text.split(' ')[1].to_i
      task = @tasks.slice!(task_index)
      return unless task
      task.force_ignore_notification = true
      return task
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
