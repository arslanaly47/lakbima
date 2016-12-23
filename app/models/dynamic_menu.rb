class DynamicMenu < ApplicationRecord
  has_many :dynamic_menus_from_account_types, inverse_of: :dynamic_menu, dependent: :destroy
  has_many :from_account_types, through: :dynamic_menus_from_account_types, source: :account_type
  has_many :dynamic_menus_to_account_types, inverse_of: :dynamic_menu, dependent: :destroy
  has_many :to_account_types,   through: :dynamic_menus_to_account_types,   source: :account_type
  has_many :transactions

  validates :name, :description, presence: true
  validate :from_account_types_should_not_be_same_as_to_account_types
  validate :should_have_atleast_one_from_account_type
  validate :should_have_atleast_one_to_account_type

  def from_account_types_should_not_be_same_as_to_account_types
    return if from_account_types.empty? || to_account_types.empty?

    unless (from_account_type_ids & to_account_type_ids).empty?
      errors.add :base, "You can't add the same account list for on both ends."
    end
  end

  def selectable_to_account_types
    to_account_type_ids = AccountType.pluck(:id) - from_account_type_ids
    AccountType.find(to_account_type_ids)
  end

  def should_have_atleast_one_from_account_type
    if from_account_types.blank?
      errors.add :base, "From account list can't be blank."
    end
  end

  def should_have_atleast_one_to_account_type
    if to_account_types.blank?
      errors.add :base, "To account list can't be blank."
    end
  end

  def from_account_ids
    from_account_types.includes(:accounts).map(&:accounts).flatten.map(&:id)
  end

  def to_account_ids
    to_account_types.includes(:accounts).map(&:accounts).flatten.map(&:id)
  end
end
