
module Core
  class PluginResponse
    attr_accessor :data
    attr_accessor :messages
    attr_accessor :options

    def initialize(params = {})
      @data = params[:data]
      @messages = params[:messages]
      @params = params[:params]
    end
  end
end
