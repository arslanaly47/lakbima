class JobTitle < ApplicationRecord
  belongs_to :department

  def department_name
    department.try(:name)
  end
end
