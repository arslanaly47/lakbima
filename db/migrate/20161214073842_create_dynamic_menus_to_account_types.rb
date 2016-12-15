class CreateDynamicMenusToAccountTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :dynamic_menus_to_account_types do |t|
      t.references :dynamic_menu, foreign_key: true, index: true
      t.references :account_type, foreign_key: true, index: true
    end
  end
end
