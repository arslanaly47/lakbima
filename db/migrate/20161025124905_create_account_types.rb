class CreateAccountTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :account_types do |t|
      t.string :name
      t.references :account_main_type, foreign_key: true, index: true

      t.timestamps
    end
  end
end
