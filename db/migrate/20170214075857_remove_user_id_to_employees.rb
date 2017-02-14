class RemoveUserIdToEmployees < ActiveRecord::Migration[5.0]
  def up
    ActiveRecord::Base.transaction do
      Employee.find_each do |employee|
        user = employee.user
        if user
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
