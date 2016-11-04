class Employee < ApplicationRecord

  has_one :salary
  has_many :vacations
  belongs_to :job_title
  validates :username, presence: true, uniqueness: true

  validates_associated :job_title

  default_scope { order('id ASC') }

  NATIONALITIES = ["Sri Lanka", "India", "Nepal", "Phillippines"]
  accepts_nested_attributes_for :salary, allow_destroy: true
  accepts_nested_attributes_for :vacations, allow_destroy: true

  delegate :department, to: :job_title, allow_nil: true
  delegate :applicable_allowances, to: :salary, allow_nil: true
  delegate :expired_allowances, to: :salary, allow_nil: true

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

  def department_name
    job_title.try(:department).try(:name)
  end
end
