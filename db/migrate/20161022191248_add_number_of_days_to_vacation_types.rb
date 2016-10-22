class AddNumberOfDaysToVacationTypes < ActiveRecord::Migration[5.0]
  def change
    add_column :vacation_types, :number_of_days, :integer
  end
end
