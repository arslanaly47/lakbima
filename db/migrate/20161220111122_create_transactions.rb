class CreateTransactions < ActiveRecord::Migration[5.0]
  def change
    create_table :transactions do |t|
      t.integer :from_account_id, foreign_key: true
      t.integer :to_account_id, foreign_key: true
      t.references :dynamic_menu, foreign_key: true, index: true
      t.decimal :amount, precision: 8, scale: 2
      t.date :happened_at

      t.timestamps
    end
  end
end
