module Notifications
  class Worker
  #
  #   attr_accessor :queue
  #   attr_accessor :notifiers
  #
  #   def initialize(queue)
  #     @queue = queue
  #     @notifiers = [
  #       Notifications::PlivoNotifier.new(),
  #       Notifications::ConsoleNotifier.new()
  #     ]
  #   end
  #
  #   def start
  #     Thread.abort_on_exception = true
  #     Thread.new do
  #       loop do
  #         process() rescue nil
  #         sleep 3
  #       end
  #     end
  #   end
  #
  #   def process
  #     @queue.each{|item|
  #       if item.notify?
  #         owner = Store.data_for(item.owner_id)['Identity::Plugin-data']
  #         number = owner[:mobile_phone_number]
  #         if number && owner[:verified]
  #           @notifiers.each { |notifier|
  #             notifier.notify(number, item.label)
  #             item.last_notified = Time.now
  #           }
  #         end
  #       end
  #     }
  #   end
  end
end
