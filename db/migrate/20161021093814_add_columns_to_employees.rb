class AddColumnsToEmployees < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :nationality, :string
    add_column :employees, :passport_no, :string
    add_column :employees, :passport_expiry, :date
    add_column :employees, :visa_no, :string
    add_column :employees, :id_no, :string
    add_column :employees, :visa_expiry, :date
    add_column :employees, :medical_expiry, :date
    add_column :employees, :job_title, :string
    add_column :employees, :basic_salary, :decimal, precision: 10, scale: 2
    add_column :employees, :fixed_allowance, :decimal, precision: 8, scale: 2
    add_column :employees, :date_of_joining, :date
  end
end
