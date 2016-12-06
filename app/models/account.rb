class Account < ApplicationRecord
  validates :account_id, :name, :description, presence: true

  default_scope { order('account_id ASC') }

  def self.available_accounts_for(journal_entry_id)
    journal_entry = JournalEntry.find(journal_entry_id)
    selected_account = find_by_id journal_entry.from_account_id
    (Account.all - [selected_account]).map { |a| [a.name, a.id] }
  end
end
