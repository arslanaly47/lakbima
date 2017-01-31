class CreateCompanies < ActiveRecord::Migration[5.0]
  def change
    create_table :companies do |t|
      t.string :business_name
      t.string :other_names
      t.text   :address
      t.string :telephone
      t.string :mobile
      t.string :commercial_registration_no
      t.date   :commercial_registration_expiry
      t.string :municipality_registration_no
      t.date   :municipality_registration_expiry

      t.timestamps
    end
  end
end
