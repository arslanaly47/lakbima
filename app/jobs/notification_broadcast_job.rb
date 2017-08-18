class NotificationBroadcastJob < ApplicationJob
  include ActionView::Helpers::TextHelper
  queue_as :default

  def perform(args)
    user = User.find_by_id(args.user_id)
    ActionCable.server.broadcast "activity_channel", message: nil, notification: render_event(args), type: "Manager", notice: "#{user.full_name} (Employee) applied for a #{pluralize(args.number_of_days, "day")} leave."
  end
  def render_event(event)
    sleep(2)
    if event.applicant_notification.present?
      ApplicationController.renderer.render(partial: 'layouts/notification', locals: { notification: event.applicant_notification })
    end
  end
end
