module Scheduler
  class Processor
    attr_accessor :renderer
    attr_accessor :parser
    attr_accessor :interpreter

    def initialize(list_items = {})
      @parser = Scheduler::Parser.new
      @renderer = Scheduler::TextRenderer.new
      @interpreter = Scheduler::Interpreter.new
    end

    def process(text, owner_id)
      if text.chomp === 'list'
        messages = @renderer.render(:on_list_request, ListItem.where(user_identifier: owner_id).order(created_at: :desc))
      else
        parsed_text = parser.parse(text)
        interpreted_data = interpreter.interpret(parsed_text)
        interpreted_data[:original_text] = text
        return unless interpreted_data[:interpreted]

        if interpreted_data[:command] === 'add'
          list_item = add_list_item(interpreted_data, owner_id)
          messages = @renderer.render(:on_create, list_item)
        elsif interpreted_data[:command] === 'remove'
          list_item = remove_list_item(interpreted_data, owner_id)
          messages = @renderer.render(:on_remove, list_item)
        end
      end

      return {data: list_item, messages: messages}
    end

    private def add_list_item(interpreted_data, owner_id)
      item = ListItem.create(
        label: interpreted_data[:label],
        original_text: interpreted_data[:original_text],
        date: interpreted_data[:date],
        time: interpreted_data[:time],
        user_identifier: owner_id
      )

      date = item.date || Date.today
      time = item.time || Time.now
      run_at = DateTime.parse(date.to_s + " " + time.to_s) if item.date && item.time

      SendReminderJob.set(wait_until: run_at).perform_later(id: item.id)

      return item
    end

    private def remove_list_item(interpreted_data, owner_id)
      return if interpreted_data[:remove_index].nil?
      list_item = ListItem.where(user_identifier: owner_id).order(created_at: :desc)[interpreted_data[:remove_index]]
      list_item.destroy
      return list_item
    end

    def process?(text)
      return true
    end

    def list_items_for(owner_id)
      return @list_items[owner_id] || []
    end
  end
end
