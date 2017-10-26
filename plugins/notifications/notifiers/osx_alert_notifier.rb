require_relative '../notifier'
module Notifications
  class OsxAlertNotifier
    def notify(target, message, params = {})
      system("osascript -e 'display notification \"#{message}\" with title \"OneLine\"'") if (/darwin/ =~ RUBY_PLATFORM) != nil
    end
  end
end
