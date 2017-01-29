class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(args)
    ActionCable.server.broadcast 'activity_channel', message: nil, type: "Manager", notice: "Employee created a leave application"
  end
end
