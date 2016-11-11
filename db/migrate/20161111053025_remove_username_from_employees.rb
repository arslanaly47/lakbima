class RemoveUsernameFromEmployees < ActiveRecord::Migration[5.0]
  def up
    remove_column :employees, :username
  end
  def down
    add_column :employees, :username, :string
  end
end
