class AddEmployeeIdToUsers < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :employee_id, :integer
  end

  def down
    remove_column :users, :employee_id
  end
end
