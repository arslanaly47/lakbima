class AddBranchIdToEmployees < ActiveRecord::Migration[5.0]
  def change
    add_reference :employees, :branch, index: true
  end
end
