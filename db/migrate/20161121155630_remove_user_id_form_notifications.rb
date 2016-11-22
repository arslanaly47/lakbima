class RemoveUserIdFormNotifications < ActiveRecord::Migration[5.0]
  def up
    remove_reference :notifications, :user
  end
  def down 
    add_reference :notifications, :user, foreign_key: true, index: true 
  end
end
