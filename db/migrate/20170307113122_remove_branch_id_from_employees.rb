class RemoveBranchIdFromEmployees < ActiveRecord::Migration[5.0]
  def up
    remove_reference :employees, :branch
  end
  def down
    add_reference :employees, :branch, index: true
  end
end
