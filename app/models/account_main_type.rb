class AccountMainType < ApplicationRecord

  validates :name, presence: true, uniqueness: true

  has_many :account_sub_types
  has_many :account_types, through: :account_sub_types
  has_many :accounts,      through: :account_types

  scope :assets,      -> { find_by(name: "Assets")      }
  scope :liabilities, -> { find_by(name: "Liabilities") }
  scope :equities,    -> { find_by(name: "Equity")      }

  def total_balance
    accounts.sum(&:total_balance).to_s
  end
end
