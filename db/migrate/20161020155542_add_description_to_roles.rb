class AddDescriptionToRoles < ActiveRecord::Migration[5.0]
  def change
    add_column :roles, :description, :text
  end
end
