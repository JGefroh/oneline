module Scheduler
  class TextRenderer
    def render(command, data = nil)
      return if data.nil?
      return render_list(data) if command === :on_list_request
      return render_remove_message(data) if command === :on_remove
      task = data
      return ["Great! I'll remind you to `#{task.label}` on #{task.date} at #{task.time.strftime('%l:%M %P %Z').strip}."] if !task.date.nil? && !task.time.nil?
      return ["Great! I'll remind you to `#{task.label}` on #{task.date} ."] if !task.date.nil? && task.time.nil?
      return ["Great! I'll remind you to `#{task.label}` today at #{task.time.strftime('%l:%M %P %Z').strip}."] if task.date.nil? && !task.time.nil?
    end

    private def render_list(tasks)
      messages = [
        "Your list:",
        "Type `remove #` to remove an item from the list."
      ]
      tasks.each_with_index{ |task, index|

        date = task.date ? task.date : Date.today
        time = task.time ? task.time.strftime('%l:%M %P %Z').strip : ''
        messages << "#{index}. #{task.original_text} (#{date.strftime('%m/%d ')}#{time})"}
      return messages
    end

    private def render_remove_message(task)
      return ["I've removed `#{task.original_text}` from your list."]
    end
  end
end
