class AccountMainType < ApplicationRecord
  has_many :account_sub_types
  has_many :account_types, through: :account_sub_types
  has_many :accounts, through: :account_types
end
