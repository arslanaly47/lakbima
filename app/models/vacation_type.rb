class VacationType < ApplicationRecord
  validates :name, :number_of_days, presence: true
end
