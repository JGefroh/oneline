module Oneline
  module Plugins
    module Identity
      class Processor
        VERIFICATION_REGEX = /^verify \d{5}$/i
        PHONE_NUMBER_REGEX = /^\d{11}$/i

        def process(text, params = {})
          begin
            return process_phone_number(text, params) if phone_number?(text)
            return process_verification(text, params) if verification?(text)
          rescue Exception => e
            puts e
          end
        end

        def process?(text, params = {})
          return verification?(text) || phone_number?(text)  if text
        end

        private def phone_number?(text)
          return !text.scan(PHONE_NUMBER_REGEX).empty?
        end
        private def verification?(text)
          return !text.scan(VERIFICATION_REGEX).empty?
        end

        private def process_phone_number(text, params)
          phone_number =  text.scan(PHONE_NUMBER_REGEX).first
          Store.data_for(params[:owner_id])["#{self.class}-data"] ||= {}
          Store.data_for(params[:owner_id])["#{self.class}-data"][:mobile_phone_number] = phone_number
          send_verification_code(params[:owner_id])
          return {messages: ["I've texted a verification code to #{phone_number}. Please confirm this is your number!"]}
        end

        private def send_verification_code(owner_id)
          verification_code = "#{rand(10000...50000)}"
          phone_number = Store.data_for(owner_id)["#{self.class}-data"][:mobile_phone_number]
          Store.data_for(owner_id)["#{self.class}-data"][:verification_code] = verification_code
          plivo = Notifications::PlivoNotifier.new
          plivo.notify(phone_number, "Please enter `verify #{verification_code}` to verify that this is your phone number.")
        end

        private def process_verification(text, params)
          identity_data = Store.data_for(params[:owner_id])["#{self.class}-data"]
          return {messages: ["You're already verified!"]} if identity_data[:verified]
          verification = text.scan(VERIFICATION_REGEX).first.split(' ')[1]
          owner_id = params[:owner_id]
          identity_data[:verified] = (verification == identity_data[:verification_code])
          return {messages: ["Great! I'll send your notifications and reminders to #{identity_data[:mobile_phone_number]}!"]} if identity_data[:verified]
          return {messages: ["Sorry, that's not the verification code I sent you."]} unless identity_data[:verified]
        end
      end
    end
  end
end
