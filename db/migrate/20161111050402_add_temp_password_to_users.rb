class AddTempPasswordToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :temp_password, :string
    add_column :users, :temp_password_changed, :boolean, default: false
  end
end
