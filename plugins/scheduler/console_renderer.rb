module Scheduler
  class ConsoleRenderer
    def render(command, data = nil)
      return if data.nil?

      render_list(data) and return if command === :on_list_request
      task = data
      puts "----- Great! I'll remind you to `#{task.label}` on #{task.date} at #{task.time.strftime('%l:%M %P').strip}." if !task.date.nil? && !task.time.nil?
      puts "----- Great! I'll remind you to `#{task.label}` on #{task.date}." if !task.date.nil? && task.time.nil?
      puts "----- Great! I'll remind you to `#{task.label}` today at #{task.time.strftime('%l:%M %P').strip}." if task.date.nil? && !task.time.nil?
    end

    private def render_list(tasks)
      puts "----- Your list:"
      puts "----- Type `remove #` to remove an item from the list."
      tasks.each_with_index{ |task, index| puts "#{index}: ----- * #{task.original_text}"}
    end
  end
end
