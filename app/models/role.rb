class Role < ApplicationRecord
  has_many :users
  has_and_belongs_to_many :permissions

  validates :name, presence: true
end
