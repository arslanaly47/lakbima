class RenameBalanceInAccounts < ActiveRecord::Migration[5.0]
  def change
    rename_column :accounts, :balance, :opening_balance
  end
end
