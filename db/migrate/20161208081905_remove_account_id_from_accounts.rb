class RemoveAccountIdFromAccounts < ActiveRecord::Migration[5.0]
  def up
    remove_column :accounts, :account_id
  end
  def down
    add_column :accounts, :account_id, :integer
  end
end
