class RemoveDateOfJoiningFromEmployees < ActiveRecord::Migration[5.0]
  def up
    remove_column :employees, :date_of_joining
  end

  def down
    add_column :employees, :date_of_joining, :date
  end
end
