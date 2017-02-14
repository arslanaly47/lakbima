class AddEmployeeIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :employee, foreign_key: true, index: true
  end
end
