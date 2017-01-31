class Company < ApplicationRecord
  validates :business_name, :address, :telephone, :subdomain, presence: true
  validates :subdomain, uniqueness: true

  after_create :create_tenant

  private
  def create_tenant
    Apartment::Tenant.create(subdomain)
  end
end
