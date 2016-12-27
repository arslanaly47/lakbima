class AddTransactionalBalanceToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_column :accounts, :transactional_balance, :decimal, precision: 8, scale: 2, default: 0
  end
end
