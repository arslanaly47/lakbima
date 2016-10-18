class AddRoleIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :role, foreign_key: true, index: true
  end
end
