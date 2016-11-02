class RemoveBasicSalaryFromEmployees < ActiveRecord::Migration[5.0]
  def up
    remove_column :employees, :basic_salary
    remove_column :employees, :fixed_allowance
  end
  def down
    add_column :employees, :basic_salary, :string
    add_column :employees, :fixed_allowance, :decimal, precision: 8, scale: 2
  end
end
