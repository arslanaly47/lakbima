class CreateVacations < ActiveRecord::Migration[5.0]
  def change
    create_table :vacations do |t|
      t.references :employee, foreign_key: true
      t.references :vacation_type, foreign_key: true
      t.date :starts_from
      t.date :ends_at

      t.timestamps
    end
  end
end
