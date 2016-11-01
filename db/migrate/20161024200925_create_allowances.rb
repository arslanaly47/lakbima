class CreateAllowances < ActiveRecord::Migration[5.0]
  def change
    create_table :allowances do |t|
      t.references :allowance_type, foreign_key: true
      t.references :salary, foreign_key: true

      t.timestamps
    end
  end
end
