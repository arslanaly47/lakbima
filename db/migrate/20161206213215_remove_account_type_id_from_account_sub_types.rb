class RemoveAccountTypeIdFromAccountSubTypes < ActiveRecord::Migration[5.0]
  def up
    remove_index :account_sub_types, :account_type_id
    remove_column :account_sub_types, :account_type_id
  end
  def down
    add_column :account_sub_types, :account_type_id, :integer
    add_index :account_sub_types, :account_type_id
  end
end
