class Currency < ApplicationRecord
  has_many :allowance_types

  validates :name, :code, :symbol, :country, presence: true
end
