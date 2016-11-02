class Employee < ApplicationRecord

  has_one :salary
  validates :username, presence: true, uniqueness: true

  default_scope { order('id ASC') }

  NATIONALITIES = ["Sri Lanka", "India", "Nepal", "Phillippines"]
  accepts_nested_attributes_for :salary, allow_destroy: true


  def full_name
    [first_name, last_name]*" "
  end

  def passport_expiry=(val)
    date = Date.strptime(val, "%m/%d/%Y") if val.present?
    write_attribute :passport_expiry, date
  end

  def visa_expiry=(val)
    date = Date.strptime(val, "%m/%d/%Y") if val.present?
    write_attribute :visa_expiry, date
  end

  def medical_expiry=(val)
    date = Date.strptime(val, "%m/%d/%Y") if val.present?
    write_attribute :medical_expiry, date
  end
end
