require 'aws-sdk'
require_relative '../notifier'

module Notifications
  class AwsSmsNotifier
    include Notifications::Notifier
    def notify(target, message, params = {})
      aws = Aws::SNS::Client.new()
      aws.publish({
        phone_number: target,
        message: message
      })
    end
  end
end