module Notifiers
  class ConsoleNotifier
    include Notifications::Notifier
    def notify(target, message, params = {})
      puts "#{message}"
    end
  end
end
