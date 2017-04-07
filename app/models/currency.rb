class Currency < ApplicationRecord
  has_many :allowance_types

  validates :name, :code, :symbol, :country, presence: true
  validates :name, :code, :symbol, uniqueness: true

  scope :default, -> { where(default: true) }

  def self.unset_default
    default_currency = Currency.default.first
    default_currency.update_attribute(:default, false) unless default_currency.blank?
  end

  def default?
    default
  end
end
