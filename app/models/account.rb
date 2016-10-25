class Account < ApplicationRecord
  validates :account_id, :name, :description, presence: true
end
