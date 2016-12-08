class AddAccountMainTypeIdToAccountSubTypes < ActiveRecord::Migration[5.0]
  def change
    add_reference :account_sub_types, :account_main_type, foreign_key: true, index: true
  end
end
