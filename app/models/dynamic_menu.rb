class DynamicMenu < ApplicationRecord
  has_many :dynamic_menus_from_account_types, inverse_of: :dynamic_menu, dependent: :destroy
  has_many :from_account_types, through: :dynamic_menus_from_account_types, source: :account_type
  has_many :dynamic_menus_to_account_types, inverse_of: :dynamic_menu, dependent: :destroy
  has_many :to_account_types,   through: :dynamic_menus_to_account_types,   source: :account_type

  validates :name, :description, presence: true
end
