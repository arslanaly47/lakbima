class AddFutureColumnToEmployees < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :future, :boolean, default: false
  end
end
