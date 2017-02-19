class RemoveUserIdToEmployees < ActiveRecord::Migration[5.0]
  def up
    remove_index :employees, :user_id
    ActiveRecord::Base.transaction do
      Employee.find_each do |employee|
        if employee.respond_to?(:user_id) && employee.user_id
          user = User.find(employee.user_id)
          user.employee_id = user.employee.id
          user.save!
        end
      end
    end
    remove_reference :employees, :user
  end

  def down
    add_reference :employees, :user, foreign_key: true, index: true
  end
end
