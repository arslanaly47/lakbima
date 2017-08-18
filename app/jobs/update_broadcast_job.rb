class UpdateBroadcastJob < ApplicationJob
  include ActionView::Helpers::TextHelper
  queue_as :default

  def perform(event)
    unless event.pending?
      ActionCable.server.broadcast "activity_channel", notification: render_event(event), message: event, type: "Manager", id: event.user_id, notice: "Your leave application for #{pluralize(event.number_of_days, "day")} has been #{event.status}."
    end
  end
  def render_event(event)
    sleep(2)
    if event.action_notification.present?
      ApplicationController.renderer.render(partial: 'layouts/notification', locals: { notification: event.action_notification })
    end
  end
end
