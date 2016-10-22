class ModifyColumnsInAllowanceTypes < ActiveRecord::Migration[5.0]
  def up
    remove_column   :allowance_types, :percentage_of_basic_salary 
    add_column      :allowance_types, :lump_sum_amount, :integer
    add_reference   :allowance_types, :currency, index: true
    add_foreign_key :allowance_types, :currencies
  end
  def down
    remove_foreign_key :allowance_types, :currencies
    remove_reference   :allowance_types, :currency
    remove_column      :allowance_types, :lump_sum_amount
    add_column      :allowance_types, :percentage_of_basic_salary, :decimal, precision: 4, scale: 1
  end
end
