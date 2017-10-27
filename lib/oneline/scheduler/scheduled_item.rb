module Scheduler
  class ScheduledItem
    include Notifications::Notifiable
    attr_accessor :label
    attr_accessor :date
    attr_accessor :time
    attr_accessor :original_text
    attr_accessor :created_at
    attr_accessor :owner_id

    def initialize(params = {})
      @label = params[:label]
      @date = params[:date]
      @time = params[:time]
      @notify_at_date = @date
      @notify_at_time = @time
      @original_text = params[:original_text]
      @owner_id = params[:owner_id]
      @created_at = DateTime.now
    end
  end
end
