class CreateAccountMainTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :account_main_types do |t|
      t.string :name

      t.timestamps
    end
  end
end
