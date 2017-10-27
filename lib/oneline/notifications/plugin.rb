module Notifications
  class Plugin
    include Core::Plugin
    def initialize()
      notification_queue = []
      Store.global_data["#{self.class}-queue"] = notification_queue
      # worker = Notifications::Worker.new(notification_queue)
      # worker.start()
      load(self)
    end
  end
end
