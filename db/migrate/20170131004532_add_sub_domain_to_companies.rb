class AddSubDomainToCompanies < ActiveRecord::Migration[5.0]
  def change
    add_column :companies, :subdomain, :string, null: false
  end
end