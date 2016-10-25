class CreateAccountSubTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :account_sub_types do |t|
      t.string :name
      t.references :account_type, foreign_key: true, index: true

      t.timestamps
    end
  end
end
