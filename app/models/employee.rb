class Employee < ApplicationRecord

  validates :username, presence: true, uniqueness: true

  default_scope { order('id ASC') }

  def full_name
    [first_name, last_name]*" "
  end
end
