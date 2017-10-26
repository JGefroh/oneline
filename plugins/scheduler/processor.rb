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
      if text.chomp === 'list'
        messages = @renderer.render(:on_list_request, @tasks)
      else
        parsed_text = parser.parse(text)
        interpreted_data = interpreter.interpret(parsed_text)
        interpreted_data[:original_text] = text
        return unless interpreted_data[:interpreted]

        if interpreted_data[:command] === 'add'
          task = add_task(interpreted_data)
          messages = @renderer.render(:on_create, task)
        elsif interpreted_data[:command] === 'remove'
          task = remove_task(interpreted_data)
          messages = @renderer.render(:on_remove, task)
        end
      end

      return {data: task, messages: messages}
    end

    private def add_task(interpreted_data)
      item = to_scheduled_item(interpreted_data)
      @tasks << item
      return item
    end

    private def remove_task(interpreted_data)
      return if interpreted_data[:remove_index].nil?
      task = @tasks.slice!(interpreted_data[:remove_index])
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
