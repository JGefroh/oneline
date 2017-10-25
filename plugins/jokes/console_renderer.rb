module Jokes
  class ConsoleRenderer
    def render(data)
      return if data.nil?
      render_message(data.joke)
    end

    def render_message(message)
      puts "----- #{message}"
    end
  end
end
