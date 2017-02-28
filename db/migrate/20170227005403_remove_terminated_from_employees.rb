class RemoveTerminatedFromEmployees < ActiveRecord::Migration[5.0]
  def up
    remove_index :employees, :terminated
    remove_column :employees, :terminated
    remove_column :employees, :future
  end

  def down
    add_column :employees, :future,     :boolean, default: false
    add_column :employees, :terminated, :boolean, default: false
    add_index  :employees, :terminated
  end
end
