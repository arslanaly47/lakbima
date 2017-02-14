namespace :user do
  desc "It saves the ids of the related employee in a user"
  task save_relative_employee_ids: :environment do
    User.all.each do |user|
      if user.employee
        user.employee_id = user.employee.id
        user.save
      end
    end
  end

end
