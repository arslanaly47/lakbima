class AllowanceType < ApplicationRecord
  validates :name, :lump_sum_amount, presence: true

  belongs_to :currency
end
