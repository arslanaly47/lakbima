class RemoveAccountTypes < ActiveRecord::Migration[5.0]
  def up
    drop_table :account_types
  end
  def down
    create_table :account_types do |t|
      t.string :name
      t.references :account_main_type, foreign_key: true, index: true

      t.timestamps
    end
  end
end
