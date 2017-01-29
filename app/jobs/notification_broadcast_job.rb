class NotificationBroadcastJob < ApplicationJob
  include ActionView::Helpers::TextHelper
  queue_as :default

  def perform(args)
    user = User.find_by_id(args.user_id)
    ActionCable.server.broadcast "activity_channel", message: nil, type: "Manager", notice: "#{user.full_name} (Employee) applied for a #{pluralize(args.number_of_days, "day")} leave."
  end
end
