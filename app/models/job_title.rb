class JobTitle < ApplicationRecord
  belongs_to :department

  validates :name, presence: true, uniqueness: true
  validates_associated :department

  def department_name
    department.try(:name)
  end
end
