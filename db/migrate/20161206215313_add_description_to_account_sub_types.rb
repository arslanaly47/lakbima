class AddDescriptionToAccountSubTypes < ActiveRecord::Migration[5.0]
  def change
    add_column :account_sub_types, :description, :text
  end
end
