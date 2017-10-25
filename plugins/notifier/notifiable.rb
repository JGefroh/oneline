module Notifier
  module Notifiable
    attr_accessor :last_notified
    attr_accessor :force_ignore_notification
    attr_accessor :notify_at_date
    attr_accessor :notify_at_time

    def notify?
      return false unless last_notified.nil?
      return false if force_ignore_notification

      if @notify_at_date && @notify_at_time
        datetime = DateTime.parse(date.to_s + " " + time.to_s)
        return DateTime.now >= datetime
      end
      return Date.today >= @notify_at_date if @notify_at_date && !@notify_at_time
      return Time.now >= @notify_at_time if !@notify_at_date && @notify_at_time
      return false
    end
  end
end
