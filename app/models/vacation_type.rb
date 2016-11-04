class VacationType < ApplicationRecord
  validates :name, presence: true

  has_many :vacations
end
