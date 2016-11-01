class Salary < ApplicationRecord

  has_many :allowances
  belongs_to :employee

  validates :basic_salary, presence: true
  accepts_nested_attributes_for :allowances, allow_destroy: true
end
