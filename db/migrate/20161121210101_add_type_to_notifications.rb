class AddTypeToNotifications < ActiveRecord::Migration[5.0]
  def change
    add_column :notifications, :notification_type, :integer
  end
end
