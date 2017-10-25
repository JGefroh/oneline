require './plugins/notifier/notifiable'
require 'date'
require 'time'
module Scheduler
  class ScheduledItem
    include Notifier::Notifiable
    attr_accessor :label
    attr_accessor :date
    attr_accessor :time
    attr_accessor :original_text

    def initialize(params = {})
      @label = params[:label]
      @date = params[:date]
      @time = params[:time]
      @original_text = params[:original_text]
      @last_notified = params[:last_notified]
    end

    def notify?
      return false unless last_notified.nil?

      if @date && @time
        datetime = DateTime.parse(date.to_s + " " + time.to_s)
        return DateTime.now >= datetime
      end
      return Date.today >= @date if @date && !@time
      return Time.now >= @time if !@date && @time
      return false
    end
  end
end
