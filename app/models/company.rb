class Company < ApplicationRecord
  validates :business_name, :address, :telephone, presence: true
end
