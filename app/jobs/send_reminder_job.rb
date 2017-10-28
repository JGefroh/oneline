class SendReminderJob < ApplicationJob
  def initialize(params = {})
    super(params)
    @notifiers = [
      Notifications::Notifiers::PlivoNotifier.new(),
      Notifications::Notifiers::ConsoleNotifier.new()
    ]
  end

  def perform(params = {})
    list_item = ListItem.find_by(id: params[:id])
    return unless list_item
    if list_item.notify? && list_item.user.mobile_phone_number_verified
      @notifiers.each { |notifier|
        notifier.notify(list_item.user.mobile_phone_number, list_item.label)
      }
      list_item.update(notified_at: DateTime.current)
    end
  end
end
