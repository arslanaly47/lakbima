class CreateSalaries < ActiveRecord::Migration[5.0]
  def change
    create_table :salaries do |t|
      t.references :employee, foreign_key: true
      t.decimal :basic_salary, precision: 10, scale: 2

      t.timestamps
    end
  end
end
