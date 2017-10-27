require './core/plugin'
require './core/store'
module Identity
  class Plugin
    include OneLine::Plugin

    def initialize
      load(self)
    end

    def load(plugin)
      super(plugin)
    end

    def process(text, params = {})
      OneLine::Store.data_for(params[:owner_id])["#{self.class}-data"] ||= {}
      OneLine::Store.data_for(params[:owner_id])["#{self.class}-data"][:mobile_phone_number] = text.split(' ').last
      return {messages: ["Thanks! I'll send you notifications to #{OneLine::Store.data_for(params[:owner_id])["#{self.class}-data"][:mobile_phone_number]}"]}
    end

    def process?(text, params = {})
      return text.downcase.index('my number is') if text
    end
  end
end
Identity::Plugin.new
