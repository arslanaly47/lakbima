class Employee < ApplicationRecord

  has_one :salary
  validates :username, presence: true, uniqueness: true

  default_scope { order('id ASC') }

  NATIONALITIES = ["Sri Lanka", "India", "Nepal", "Phillippines"]
  accepts_nested_attributes_for :salary, allow_destroy: true


  def full_name
    [first_name, last_name]*" "
  end
end
