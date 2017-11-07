class ListItem < ApplicationRecord
  include Notifications::Notifiable

  alias_attribute :notify_at_date, :date
  alias_attribute :notify_at_time, :time

  def calculate_run_at
    run_at_date = date || Date.today
    run_at_time = time || Time.current
    run_at = Time.parse(run_at_date.to_s + ' ' + run_at_time.to_s).in_time_zone(Time.zone)
    puts "Now: #{Time.current}"
    puts "DST?: #{run_at_time.dst?}"
    puts "Run at: #{run_at}"
    return run_at
  end

  def user
    return User.find_or_create_by(user_identifier: self.user_identifier)
  end
end
