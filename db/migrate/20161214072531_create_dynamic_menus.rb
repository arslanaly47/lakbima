class CreateDynamicMenus < ActiveRecord::Migration[5.0]
  def change
    create_table :dynamic_menus do |t|
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
