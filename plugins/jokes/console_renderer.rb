module Jokes
  class ConsoleRenderer
    def render(data)
      return if data.nil?
      puts "----- #{data.joke}"
    end
  end
end
