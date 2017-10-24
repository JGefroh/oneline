module Notifier
  module Notifiable
    attr_accessor :last_notified

    def notify?
      raise "Unimplemented"
    end
  end
end
