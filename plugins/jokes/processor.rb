require_relative './gateways/Icanhazdadjoke_gateway'
require_relative './gateways/Icndb_gateway'
require_relative 'console_renderer'
require './utilities/requestor'

module Jokes
  class Processor
    def initialize()
      @gateways = {}
      @renderer = Jokes::ConsoleRenderer.new
      @gateways[:dad] = Jokes::IcanhazdadjokeGateway.new
      @gateways[:chucknorris] = Jokes::IcndbGateway.new
    end

    def process(text)
      category = :dad
      category = :chucknorris if text.include?('chuck norris')

      joke = @gateways[category].get_joke()

      @renderer.render(joke)
    end

    def process?(text)
      matches = text.scan(/((tell me a .*joke))/i)
      return !matches.empty?
    end
  end
end
