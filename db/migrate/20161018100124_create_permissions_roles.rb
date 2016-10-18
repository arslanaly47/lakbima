class CreatePermissionsRoles < ActiveRecord::Migration[5.0]
  def change
    create_table :permissions_roles do |t|
      t.references :role, foreign_key: true, index: true
      t.references :permission, foreign_key: true, index: true
    end
  end
end
