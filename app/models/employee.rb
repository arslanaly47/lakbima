class Employee < ApplicationRecord

  validates :username, presence: true

  def full_name
    [first_name, last_name]*" "
  end
end
