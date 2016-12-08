class AccountSubType < ApplicationRecord
  belongs_to :account_main_type
  validates :name, :description, :account_main_type, presence: true
end
