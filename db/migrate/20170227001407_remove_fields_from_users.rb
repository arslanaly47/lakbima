class RemoveFieldsFromUsers < ActiveRecord::Migration[5.0]
  def up
    remove_column :users, :first_name
    remove_column :users, :last_name
    remove_column :users, :phone_number
    remove_column :users, :address
  end

  def down
    add_column :users, :address,      :text
    add_column :users, :phone_number, :string
    add_column :users, :last_name,    :string
    add_column :users, :first_name,   :string
  end
end
