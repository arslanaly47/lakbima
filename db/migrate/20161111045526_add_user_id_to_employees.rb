class AddUserIdToEmployees < ActiveRecord::Migration[5.0]
  def change
    add_reference :employees, :user, foreign_key: true, index: true
  end
end
