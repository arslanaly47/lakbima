class RemoveBranches < ActiveRecord::Migration[5.0]
  def up
    drop_table :branches
  end
  def down
    create_table :branches do |t|
      t.string :name
      t.text :address
      t.text :description

      t.timestamps
    end
  end
end
