class CreateNotifications < ActiveRecord::Migration[5.0]
  def change
    create_table :notifications do |t|
      t.references :user, foreign_key: true, index: true
      t.string :content

      t.timestamps
    end
  end
end
