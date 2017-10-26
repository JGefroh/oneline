module Jokes
  class ConsoleRenderer
    def render(data)
      return if data.nil?
      return render_message(data.joke)
    end

    def render_message(message)
      return ["----- #{message}"]
    end
  end
end
