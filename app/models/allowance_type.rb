class AllowanceType < ApplicationRecord
  validates :name, presence: true
  validates :percentage_of_basic_salary, presence: true, inclusion: 1..100
end
