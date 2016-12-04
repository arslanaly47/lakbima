class JournalEntry < ApplicationRecord
  belongs_to :journal_entry_session
  belongs_to :to_account,   class_name: "Account"
  belongs_to :from_account, class_name: "Account"

  validates :journal_entry_session, :amount, :description,
            :from_account_id, :to_account_id, :happened_at, presence: true
  validate :from_and_to_account_can_not_be_same

  def happened_at=(val)
    date = Date.strptime(val, "%m/%d/%Y") if val.present?
    write_attribute :happened_at, date
  end

  def from_and_to_account_can_not_be_same
    if from_account_id == to_account_id
      errors.add :base, "From and to account can't be the same. Please choose different ones."
    end
  end
end
