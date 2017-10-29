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

      date = list_item.date ? list_item.date : Date.today
      time = list_item.time ? list_item.time.strftime('%l:%M %P %Z').strip : ''
      @notifiers.each { |notifier|
        notifier.notify(list_item.user.mobile_phone_number, "#{list_item.original_text} | (#{date.strftime('%m/%d ')}#{time})")
      }
      list_item.update(notified_at: DateTime.current)
    end
  end
end
