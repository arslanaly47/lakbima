class Account < ApplicationRecord
  belongs_to :account_type
  has_one :account_sub_type, through: :account_type
  has_one :account_main_type, through: :account_sub_type

  validates :account_type_id, :name, :description, presence: true

  def self.available_accounts_for(journal_entry_id)
    journal_entry = JournalEntry.find(journal_entry_id)
    selected_account = find_by_id journal_entry.from_account_id
    (Account.all - [selected_account]).map { |a| [a.name, a.id] }
  end
end
