module Identity
  class Processor
    VERIFICATION_REGEX = /^verify \d{5}$/i
    PHONE_NUMBER_REGEX = /^\d{11}$/i
    TIME_ZONE_REGEX = /((timezone|tz|time zone) is (.+$))/i
    TIME_ZONE_MAP = {
      AKST: 'Alaska',
      AKDT: 'Alaska',
      AST: 'Atlantic Time (Canada)',
      ADT: 'Atlantic Time (Canada)',
      EST: 'Eastern Time (US & Canada)',
      EDT: 'Eastern Time (US & Canada)',
      CST: 'Central Time (US & Canada)',
      CDT: 'Central Time (US & Canada)',
      HST: 'Hawaii',
      HDT: 'Hawaii',
      MST: 'Mountain Time (US & Canada)',
      MDT: 'Mountain Time (US & Canada)',
      PST: 'Pacific Time (US & Canada)',
      PDT: 'Pacific Time (US & Canada)'
    }

    def process(text, params = {})
      begin
        return process_phone_number(text, params) if phone_number?(text)
        return process_verification(text, params) if verification?(text)
        return process_time_zone_change(text, params) if time_zone?(text)
      rescue Exception => e
        puts e
      end
    end

    def process?(text, params = {})
      return verification?(text) || phone_number?(text) || time_zone?(text)  if text
    end

    private def phone_number?(text)
      return !text.scan(PHONE_NUMBER_REGEX).empty?
    end
    private def verification?(text)
      return !text.scan(VERIFICATION_REGEX).empty?
    end
    private def time_zone?(text)
      return !text.scan(TIME_ZONE_REGEX).empty?
    end

    private def process_phone_number(text, params)
      phone_number =  text.scan(PHONE_NUMBER_REGEX).first
      user = User.find_or_create_by(user_identifier: params[:owner_id])
      user.update(mobile_phone_number: phone_number, mobile_phone_number_verified: false)
      send_verification_code(user)
      return {messages: ["I've texted a verification code to #{phone_number}. Please confirm this is your number!"]}
    end

    private def send_verification_code(user)
      verification_code = "#{rand(10000...50000)}"
      user.update(verification_code: verification_code)
      plivo = ::Notifications::Notifiers::PlivoNotifier.new
      plivo.notify(user.mobile_phone_number, "Please enter `verify #{verification_code}` to verify that this is your phone number.")
    end

    private def process_verification(text, params)
      user = User.find_by(user_identifier: params[:owner_id])
      return {messages: ["You're already verified!"]} if user.mobile_phone_number_verified
      verification = text.scan(VERIFICATION_REGEX).first.split(' ')[1]
      owner_id = params[:owner_id]
      user.update(mobile_phone_number_verified: (verification == user.verification_code))
      return {messages: ["Great! I'll send your notifications and reminders to #{user.mobile_phone_number}!"]} if user.mobile_phone_number_verified
      return {messages: ["Sorry, that's not the verification code I sent you."]} unless user.mobile_phone_number_verified
    end

    private def process_time_zone_change(text, params)
      user = User.find_or_create_by(user_identifier: params[:owner_id])
      time_zone = text.scan(TIME_ZONE_REGEX).last.last
      zone = ActiveSupport::TimeZone[time_zone].name unless ActiveSupport::TimeZone[time_zone].nil?
      zone = ActiveSupport::TimeZone[TIME_ZONE_MAP[time_zone.upcase.to_sym]].name unless zone || TIME_ZONE_MAP[time_zone.upcase.to_sym].nil?
      if zone
        user.update(time_zone: zone)
        return {messages: ["I've set your time zone to #{zone}."]}
      else
        return {messages: ["Sorry, I didn't recognize #{time_zone} as a valid time zone."]}
      end
    end
  end
end
