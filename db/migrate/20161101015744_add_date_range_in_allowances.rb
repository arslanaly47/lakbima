class AddDateRangeInAllowances < ActiveRecord::Migration[5.0]
  def change
    add_column :allowances, :starts_from, :date
    add_column :allowances, :ends_at, :date
  end
end
