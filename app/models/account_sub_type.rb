class AccountSubType < ApplicationRecord
  validates :name, :description, :account_main_type, presence: true
  validates :name, uniqueness: true

  has_many :account_types
  belongs_to :account_main_type
end
