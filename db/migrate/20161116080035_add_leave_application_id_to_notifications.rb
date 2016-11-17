class AddLeaveApplicationIdToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_reference :notifications, :leave_application, foreign_key: true, index: true
  end
end
