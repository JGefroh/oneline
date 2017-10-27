module Scheduler
  class Processor
    attr_accessor :renderer
    attr_accessor :parser
    attr_accessor :interpreter

    def initialize(tasks = {})
      @parser = Scheduler::Parser.new
      @renderer = Scheduler::ConsoleRenderer.new
      @interpreter = Scheduler::Interpreter.new
      @tasks = tasks
    end

    def process(text, owner_id)
      @tasks[owner_id] ||= []
      if text.chomp === 'list'
        messages = @renderer.render(:on_list_request, @tasks[owner_id])
      else
        parsed_text = parser.parse(text)
        interpreted_data = interpreter.interpret(parsed_text)
        interpreted_data[:original_text] = text
        return unless interpreted_data[:interpreted]

        if interpreted_data[:command] === 'add'
          task = add_task(interpreted_data, owner_id)
          messages = @renderer.render(:on_create, task)
        elsif interpreted_data[:command] === 'remove'
          task = remove_task(interpreted_data, owner_id)
          messages = @renderer.render(:on_remove, task)
        end
      end

      task.owner_id = owner_id if task

      return {data: task, messages: messages}
    end

    private def add_task(interpreted_data, owner_id)
      @tasks[owner_id] ||= []
      item = to_scheduled_item(interpreted_data)
      @tasks[owner_id] << item
      return item
    end

    private def remove_task(interpreted_data, owner_id)
      @tasks[owner_id] ||= []
      return if interpreted_data[:remove_index].nil?
      task = @tasks[owner_id].slice!(interpreted_data[:remove_index])
      return unless task
      task.force_ignore_notification = true
      return task
    end

    def process?(text)
      return true
    end

    def tasks_for(owner_id)
      return @tasks[owner_id] || []
    end

    def to_scheduled_item(interpreted_data)
      s = Scheduler::ScheduledItem.new(interpreted_data)
      return s
    end
  end
end
