class Account < ApplicationRecord

  has_one :account_sub_type,  through: :account_type
  has_one :account_main_type, through: :account_sub_type

  has_many :from_journal_entries, class_name: "JournalEntry", foreign_key: :from_account_id
  has_many :from_transactions,    class_name: "Transaction",  foreign_key: :from_account_id
  has_many :to_journal_entries,   class_name: "JournalEntry", foreign_key: :to_account_id
  has_many :to_transactions,      class_name: "Transaction",  foreign_key: :to_account_id

  belongs_to :account_type

  validates :account_type_id, :name, :description, presence: true

  def self.available_accounts_for(journal_entry_id)
    journal_entry = JournalEntry.find(journal_entry_id)
    available_ids = Account.pluck(:id) - [journal_entry.from_account_id]
    Account.find(available_ids).pluck(:name, :id)
  end

  def total_balance(start_date=nil, end_date=nil)
    if start_date && end_date
      calculated_transactional_balance = 0.0
      calculated_transactional_balance -= from_journal_entries_balance(start_date, end_date)
      calculated_transactional_balance -= from_transactions_balance(start_date, end_date)
      calculated_transactional_balance += to_journal_entries_balance(start_date, end_date)
      calculated_transactional_balance += to_transactions_balance(start_date, end_date)
      (opening_balance || 0.0) + calculated_transactional_balance
    else
      (opening_balance || 0.0) + (transactional_balance || 0.0)
    end
  end

  def self.min_date
    [Transaction.minimum(:happened_at), JournalEntry.minimum(:happened_at)].min || Date.today 
  end

  def from_journal_entries_balance(start_date, end_date)
    from_journal_entries.where(happened_at: start_date..end_date).sum(:amount) 
  end

  def from_transactions_balance(start_date, end_date)
    from_transactions.where(happened_at: start_date..end_date).sum(:amount) 
  end

  def to_journal_entries_balance(start_date, end_date)
    to_journal_entries.where(happened_at: start_date..end_date).sum(:amount) 
  end

  def to_transactions_balance(start_date, end_date)
    to_transactions.where(happened_at: start_date..end_date).sum(:amount) 
  end
end
