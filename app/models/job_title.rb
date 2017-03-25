class JobTitle < ApplicationRecord
  belongs_to :department
  has_many :employees

  validates :name, :department, presence: true
  validates :name, uniqueness: true

  def department_name
    department.try(:name)
  end
end
