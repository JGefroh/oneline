class ApplicationJob < ActiveJob::Base
  def queue_name
    :default
  end
end
