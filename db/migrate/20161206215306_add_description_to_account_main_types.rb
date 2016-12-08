class AddDescriptionToAccountMainTypes < ActiveRecord::Migration[5.0]
  def change
    add_column :account_main_types, :description, :text
  end
end
