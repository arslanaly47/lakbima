class NotificationBroadcastJob < ApplicationJob
  queue_as :default

  def perform(args)
    ActionCable.server.broadcast 'activity_channel', message: render_event
  end

  private
  def render_event
    puts "*"*80
    # ApplicationController.renderer.render(partial: 'layouts/footer')
    puts "*"*80
  end
end
