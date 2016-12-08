class AddAccountSubTypeIdToAccounts < ActiveRecord::Migration[5.0]
  def change
    add_reference :accounts, :account_sub_type, foreign_key: true, index: true
  end
end
