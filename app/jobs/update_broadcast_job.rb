class UpdateBroadcastJob < ApplicationJob
  include ActionView::Helpers::TextHelper
  queue_as :default

  def perform(event)
    unless event.pending?
      ActionCable.server.broadcast "activity_channel", message: event, type: "Manager", id: event.user_id, notice: "Your leave application for #{pluralize(event.number_of_days, "day")} has been #{event.status} ."
    end
  end
end
