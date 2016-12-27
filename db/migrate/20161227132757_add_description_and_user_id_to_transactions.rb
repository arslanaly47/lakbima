class AddDescriptionAndUserIdToTransactions < ActiveRecord::Migration[5.0]
  def change
    add_column :transactions, :description, :text
    add_reference :transactions, :user, foreign_key: true, index: true
  end
end
