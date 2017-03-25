class AllowanceType < ApplicationRecord

  has_many :allowances
  belongs_to :currency

  default_scope { order('id ASC') }

  validates :name, :lump_sum_amount, :currency, presence: true
  validates :name, uniqueness: true

  def currency_symbol
    currency && currency.symbol
  end
end
