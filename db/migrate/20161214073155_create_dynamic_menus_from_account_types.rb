class CreateDynamicMenusFromAccountTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :dynamic_menus_from_account_types, id: false do |t|
      t.references :dynamic_menu, foreign_key: true, index: true
      t.references :account_type, foreign_key: true, index: true
    end
  end
end
