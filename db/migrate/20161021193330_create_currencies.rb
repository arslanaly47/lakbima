class CreateCurrencies < ActiveRecord::Migration[5.0]
  def change
    create_table :currencies do |t|
      t.string :name
      t.string :code
      t.string :symbol
      t.string :country

      t.timestamps
    end
  end
end
