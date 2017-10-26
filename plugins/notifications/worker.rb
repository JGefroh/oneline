require_relative 'notifiers/aws_sms_notifier'
require_relative 'notifiers/osx_alert_notifier'
require_relative 'notifiers/console_notifier'
require 'time'
$stdout.sync = true

module Notifications
  class Worker

    attr_accessor :queue
    attr_accessor :notifiers

    def initialize(queue)
      @queue = queue
      @notifiers = [
        Notifications::AwsSmsNotifier.new(),
        Notifications::OsxAlertNotifier.new(),
        Notifications::ConsoleNotifier.new()
      ]
    end

    def start
      Thread.abort_on_exception = true
      Thread.new do
        loop do
          process()
          sleep 3
        end
      end
    end

    def process
      @queue.each{|item|
        if item.notify?
          @notifiers.each { |notifier|
            notifier.notify(ENV['PHONE_NUMBER'], item.label)
            item.last_notified = Time.now
          }
        end
      }
    end
  end
end
