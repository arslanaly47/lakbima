class RemoveEmployeeIdToSalaries < ActiveRecord::Migration[5.0]
  def up
    remove_reference :salaries, :employee
  end

  def down
    add_reference :salaries, :employee, foreign_key: true
  end
end
