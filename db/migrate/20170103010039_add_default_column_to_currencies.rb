class AddDefaultColumnToCurrencies < ActiveRecord::Migration[5.0]
  def change
    add_column :currencies, :default, :boolean, default: false
  end
end
