class CreateAccountSubTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :account_sub_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
