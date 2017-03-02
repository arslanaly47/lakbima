class AddUserIdToSalaries < ActiveRecord::Migration[5.0]
  def change
    add_reference :salaries, :user, foreign_key: true
  end
end
