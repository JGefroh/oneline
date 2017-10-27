module Jokes
  class Processor
    def initialize()
      @gateways = {}
      @renderer = Jokes::ConsoleRenderer.new
      @gateways[:dad] = Gateways::IcanhazdadjokeGateway.new
      @gateways[:chucknorris] = Gateways::IcndbGateway.new
    end

    def process(text)
      category = :dad
      category = :chucknorris if text.include?('chuck norris')

      joke = @gateways[category].get_joke() rescue nil

      messages = @renderer.render(joke) if joke
      messages = @renderer.render_message("The only joke I could think of is my own ability to tell them. :(") unless joke
      return {data: joke, messages: messages}
    end

    def process?(text)
      matches = text.scan(/((tell me a .*joke))/i)
      return !matches.empty?
    end
  end
end
