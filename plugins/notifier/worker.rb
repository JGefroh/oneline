require_relative 'aws_sms_notifier'
require 'time'
$stdout.sync = true

module Notifier
  class Worker

    attr_accessor :queue
    attr_accessor :notifier

    def initialize(queue)
      @queue = queue
      @notifier = Notifier::AwsSmsNotifier.new()
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
          @notifier.notify(ENV['PHONE_NUMBER'], item.original_text)
          item.last_notified = Time.now
        end
      }
    end
  end
end
