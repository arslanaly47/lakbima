class CreateNotificationUsers < ActiveRecord::Migration[5.0]
  def change
    create_table :notification_users do |t|
      t.references :notification, foreign_key: true, index: true
      t.references :user, foreign_key: true, index: true
      t.boolean :read, default: false

      t.timestamps
    end
  end
end
