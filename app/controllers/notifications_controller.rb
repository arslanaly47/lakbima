class NotificationsController < ApplicationController
  def index
    @notifications = current_user.received_notifications
  end

  def mark_as_read
    if current_user.mark_notification(params[:id])
      render json: { read: true }
    else
      render json: { read: false }
    end
  end
end
