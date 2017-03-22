class Company < ApplicationRecord

  validates :business_name, :address, :telephone, :subdomain, presence: true
  validates :subdomain, uniqueness: true

  after_create :create_tenant

  def rename_tenant(old_tenant_name)
    ActiveRecord::Base.connection.exec_query("ALTER SCHEMA \"#{old_tenant_name}\" RENAME TO \"#{subdomain}\"")
    Apartment::Tenant.switch!(subdomain)
  end

  def commercial_registration_expiry=(val)
    date = Date.strptime(val, "%m/%d/%Y") if val.present?
    write_attribute :commercial_registration_expiry, date
  end

  def municipality_registration_expiry=(val)
    date = Date.strptime(val, "%m/%d/%Y") if val.present?
    write_attribute :municipality_registration_expiry, date
  end

  def url
    "http://#{subdomain}.#{ENV["DOMAIN_NAME"]}"
  end

  private

  def create_tenant
    Apartment::Tenant.create(subdomain)
    seed_tenant
  end

  def seed_tenant
    current_tenant = Apartment::Tenant.current
    Apartment::Tenant.switch! subdomain
    CreateAdminUser.new.call
    Apartment::Tenant.switch! current_tenant
  end
end
