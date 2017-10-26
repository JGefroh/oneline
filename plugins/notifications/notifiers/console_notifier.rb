require_relative '../notifier'

module Notifications
  class ConsoleNotifier
    include Notifications::Notifier
    def notify(target, message, params = {})
      puts "#{message}"
    end
  end
end
