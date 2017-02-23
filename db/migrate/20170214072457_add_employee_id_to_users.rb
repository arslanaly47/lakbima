class AddEmployeeIdToUsers < ActiveRecord::Migration[5.0]
  def up
    add_column :users, :employee_id, :integer
    add_foreign_key :users, "public.employees", column: :employee_id
  end

  def down
    remove_column :users, :employee_id
  end
end
