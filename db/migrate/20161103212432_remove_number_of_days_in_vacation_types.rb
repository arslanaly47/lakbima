class RemoveNumberOfDaysInVacationTypes < ActiveRecord::Migration[5.0]
  def up
    remove_column :vacation_types, :number_of_days
  end
  def down
    add_column :vacation_types, :number_of_days, :integer
  end
end
