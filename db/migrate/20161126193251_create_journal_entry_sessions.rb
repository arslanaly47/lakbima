class CreateJournalEntrySessions < ActiveRecord::Migration[5.0]
  def change
    create_table :journal_entry_sessions do |t|
      t.references :user, foreign_key: true, index: true
      t.datetime :closed_at
      t.timestamps
    end
  end
end
