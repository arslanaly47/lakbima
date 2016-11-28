class CreateJournalEntries < ActiveRecord::Migration[5.0]
  def change
    create_table :journal_entries do |t|
      t.references :journal_entry_session, foreign_key: true, index: true
      t.date :happened_at
      t.decimal :amount, precision: 8, scale: 2
      t.text :description
      t.integer :from_account_id, foreign_key: true, index: true
      t.integer :to_account_id, foreign_key: true, index: true
      t.timestamps
    end
  end
end
