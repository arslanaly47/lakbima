class Role < ApplicationRecord
  has_many :users
  has_and_belongs_to_many :permissions

  default_scope { order('id ASC') }

  validates :name, presence: true
end
