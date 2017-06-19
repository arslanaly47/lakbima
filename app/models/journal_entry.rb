class JournalEntry < ApplicationRecord
  belongs_to :journal_entry_session
  belongs_to :to_account,   class_name: "Account"
  belongs_to :from_account, class_name: "Account"

  validates :journal_entry_session, :amount, :description,
            :from_account_id, :to_account_id, :happened_at, presence: true
  validates :amount, numericality: { greater_than_or_equal_to: 0 }
  validate :from_and_to_account_can_not_be_same

  after_save :update_associated_accounts

  def happened_at=(val)
    date = Date.strptime(val, "%d/%m/%Y") if val.present?
    write_attribute :happened_at, date
  end

  def from_and_to_account_can_not_be_same
    return if from_account_id.nil? || to_account_id.nil?

    if from_account_id == to_account_id
      errors.add :base, "FROM and TO accounts can't be the same. Please choose different ones."
    end
  end

  def update_associated_accounts
    from_account.transactional_balance -= amount
    from_account.save
    to_account.transactional_balance += amount
    to_account.save
  end
end
