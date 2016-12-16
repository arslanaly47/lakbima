class AccountType < ApplicationRecord
  belongs_to :account_sub_type
  has_one :account_main_type, through: :account_sub_type
  has_many :dynamic_menus_from_account_types, inverse_of: :dynamic_menu
  has_many :from_dynamic_menus, through: :dynamic_menus_from_account_types, source: :dynamic_menu

  validates :account_sub_type, :name, :description, presence: true
end
