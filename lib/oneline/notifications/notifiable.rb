module Notifications
  module Notifiable
    attr_accessor :notified_at
    attr_accessor :notify_at_date
    attr_accessor :notify_at_time

    def notify?
      return notified_at.nil?
    end
  end
end
