class Employee < ApplicationRecord

  validates :username, presence: true

  default_scope { order('id ASC') }

  NATIONALITIES = ["Sri Lanka", "India", "Nepal", "Phillippines"]

  def full_name
    [first_name, last_name]*" "
  end
end
