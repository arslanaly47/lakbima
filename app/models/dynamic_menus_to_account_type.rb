class DynamicMenusToAccountType < ApplicationRecord
  belongs_to :dynamic_menu, inverse_of: :dynamic_menus_from_account_types
  belongs_to :account_type
end
