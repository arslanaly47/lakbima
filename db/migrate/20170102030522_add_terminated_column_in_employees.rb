class AddTerminatedColumnInEmployees < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :terminated, :boolean, default: false
    add_index :employees, :terminated
  end
end
