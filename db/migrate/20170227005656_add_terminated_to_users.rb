class AddTerminatedToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :terminated, :boolean, default: false
    add_index  :users, :terminated
    add_column :users, :future, :boolean, default: false
    add_index  :users, :future
  end
end
