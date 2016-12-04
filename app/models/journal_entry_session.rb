class JournalEntrySession < ApplicationRecord

  has_many :journal_entries
  belongs_to :user

  validates :user, presence: true

  scope :active, -> { where(closed_at: nil) }

  def active?
    !closed_at
  end

  def close!
    update_attribute :closed_at, Time.now
  end
end
