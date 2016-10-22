class AllowanceType < ApplicationRecord
  validates :name, :lump_sum_amount, presence: true
end
