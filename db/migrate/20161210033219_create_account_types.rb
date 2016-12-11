class CreateAccountTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :account_types do |t|
      t.references :account_sub_type, foreign_key: true, index: true
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
