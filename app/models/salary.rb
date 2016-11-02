class Salary < ApplicationRecord

  has_many :allowances
  has_many :applicable_allowances, -> { applicable }, class_name: "Allowance"
  has_many :expired_allowances,    -> { expired }, class_name: "Allowance"
  belongs_to :employee

  validates :basic_salary, presence: true
  accepts_nested_attributes_for :allowances, allow_destroy: true

  def total_amount
    total_allowances_amount = 0
    unless applicable_allowances.blank?
      total_allowances_amount = applicable_allowances.map(&:lump_sum_amount).inject do |sum, i| 
        sum + i
      end
    end
    basic_salary + total_allowances_amount
  end
end
