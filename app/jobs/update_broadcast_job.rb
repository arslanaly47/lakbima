class UpdateBroadcastJob < ApplicationJob
  queue_as :default

  def perform(event)
    puts "*"*80
    puts event.inspect
    puts "*"*80
    ActionCable.server.broadcast 'activity_channel', message: event, type: "Manager", id: event.user_id
  end
end
