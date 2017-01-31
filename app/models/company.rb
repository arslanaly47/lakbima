class Company < ApplicationRecord
  validates :business_name, :address, :telephone, :subdomain, presence: true
  validates :subdomain, uniqueness: true
end
