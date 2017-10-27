require_relative 'notifiers/plivo_notifier'
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
        Notifications::PlivoNotifier.new(),
        Notifications::ConsoleNotifier.new()
      ]
    end

    def start
      Thread.abort_on_exception = true
      Thread.new do
        loop do
          process() rescue nil
          sleep 3
        end
      end
    end

    def process
      @queue.each{|item|
        if item.notify?
          number = OneLine::Store.data_for(item.owner_id)['Identity::Plugin-data'][:mobile_phone_number]
          if number
            @notifiers.each { |notifier|
              notifier.notify(number, item.label)
              item.last_notified = Time.now
            }
          end
        end
      }
    end
  end
end
