class JournalEntry < ApplicationRecord
  belongs_to :journal_entry_session
  belongs_to :to_account,   class_name: "Account"
  belongs_to :from_account, class_name: "Account"

  validates :journal_entry_session, :amount, :description,
            :from_account_id, :to_account_id, :happened_at, presence: true

  def happened_at=(val)
    date = Date.strptime(val, "%m/%d/%Y") if val.present?
    write_attribute :happened_at, date
  end
end
