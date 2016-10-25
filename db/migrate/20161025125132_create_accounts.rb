class CreateAccounts < ActiveRecord::Migration[5.0]
  def change
    create_table :accounts do |t|
      t.integer :account_id
      t.string :name
      t.text :description

      t.timestamps
    end
  end
end
