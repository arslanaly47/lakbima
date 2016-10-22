class CreateAllowanceTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :allowance_types do |t|
      t.string :name
      t.string :description
      t.decimal :percentage_of_basic_salary, precision: 4, scale: 1

      t.timestamps
    end
  end
end
