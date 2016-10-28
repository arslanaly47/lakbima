class AllowanceType < ApplicationRecord

  has_many :allowances
  belongs_to :currency

  default_scope { order('id ASC') }

  validates :name, :lump_sum_amount, presence: true


  validates_associated :currency

  def currency_symbol
    currency && currency.symbol
  end
end
