class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(args)
    user = User.find_by_id(args.user_id)
    ActionCable.server.broadcast 'activity_channel', message: nil, type: "Manager", notice: "#{user.full_name} (Employee) applied for a #{args.number_of_days} #{(args.number_of_days > 1) ? 'days' : 'day'} leave" 
  end
end
