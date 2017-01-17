class Transaction < ApplicationRecord
  has_many :attachments, as: :attachable
  belongs_to :from_account, class_name: "Account"
  belongs_to :to_account,   class_name: "Account"
  belongs_to :dynamic_menu
  belongs_to :user

  validates :from_account, :to_account, :amount, :happened_at, :user, presence: true
  validate  :from_account_id_can_not_be_same_as_to_account
  validate :from_account_id_should_be_valid
  validate :from_account_id_should_be_valid

  accepts_nested_attributes_for :attachments,
                                allow_destroy: true,
                                reject_if: proc { |attributes|
                                  attributes['image'].blank?
                                }
  after_create :update_associated_accounts

  def from_account_id_can_not_be_same_as_to_account
    return if from_account_id.nil? || to_account_id.nil?

    if from_account_id == to_account_id
      errors.add :base, "From account ID can't be same as to account ID."
    end
  end

  def from_account_id_should_be_valid
    unless dynamic_menu.nil? || dynamic_menu.from_account_ids.include?(from_account_id)
      errors.add :base, "From account should be valid."
    end
  end

  def to_account_id_should_be_valid
    unless dynamic_mneu.nil? || dynamic_menu.to_account_ids.include?(to_account_id)
      errors.add :base, "To account should be valid."
    end
  end

  def happened_at=(val)
    date = Date.strptime(val, "%m/%d/%Y") if val.present?
    write_attribute :happened_at, date
  end

  def update_associated_accounts
    from_account.transactional_balance -= amount
    from_account.save
    to_account.transactional_balance += amount
    to_account.save
  end
end
