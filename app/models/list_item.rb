class ListItem < ApplicationRecord
  include Notifications::Notifiable
  alias_attribute :notify_at_date, :date
  alias_attribute :notify_at_time, :time

  def user
    return User.find_or_create_by(user_identifier: self.user_identifier)
  end
end
