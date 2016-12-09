class AccountSubType < ApplicationRecord
  has_many :accounts

  belongs_to :account_main_type
  validates :name, :description, :account_main_type, presence: true
end
