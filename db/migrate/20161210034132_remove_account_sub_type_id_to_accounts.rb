class RemoveAccountSubTypeIdToAccounts < ActiveRecord::Migration[5.0]
  def up
    remove_index :accounts, :account_sub_type_id
    remove_column :accounts, :account_sub_type_id
    add_column :accounts, :account_type_id, :integer
    add_index :accounts, :account_type_id
  end
  def down
    add_column :account, :account_sub_type_id, :integer
    add_index :account, :account_sub_type_id
    remove_index :accounts, :account_type_id
    remove_column :accounts, :account_type_id
  end
end
