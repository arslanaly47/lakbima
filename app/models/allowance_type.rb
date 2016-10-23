class AllowanceType < ApplicationRecord
  validates :name, :lump_sum_amount, presence: true

  belongs_to :currency

  validates_associated :currency

  def currency_symbol
    currency && currency.symbol
  end
end
