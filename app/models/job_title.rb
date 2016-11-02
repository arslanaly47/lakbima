class JobTitle < ApplicationRecord
  belongs_to :department
  has_many :employees

  validates :name, presence: true, uniqueness: true
  validates_associated :department

  def department_name
    department.try(:name)
  end
end
