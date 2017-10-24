require 'date'
require 'time'
require 'aws-sdk'

module Notifier
  class AwsSmsNotifier
    def notify(target, message, type = :sms)
      aws = Aws::SNS::Client.new()
      aws.publish({
        phone_number: target,
        message: message
      })
    end
  end
end
