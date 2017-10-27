module Jokes
  class Joke
    attr_accessor :joke

    def initialize(params = {})
      @joke = params['joke'] || params[:joke]
    end
  end
end
