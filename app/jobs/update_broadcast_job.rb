class UpdateBroadcastJob < ApplicationJob
  queue_as :default

  def perform(event)
    unless event.pending?
      ActionCable.server.broadcast "activity_channel", message: event, type: "Manager", id: event.user_id, notice: "Your leave application has been #{event.status} ."
    end
  end
end
