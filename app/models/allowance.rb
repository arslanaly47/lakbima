class Allowance < ApplicationRecord
  belongs_to :allowance_type
  belongs_to :salary

  validates_associated :allowance_type, :salary
  validates :starts_from, :ends_at, presence: true
  validate :ends_at_should_be_after_starts_from

  def starts_from=(val)
    date = Date.strptime(val, "%m/%d/%Y") if val.present?
    write_attribute :starts_from, date
  end

  def ends_at=(val)
    date = Date.strptime(val, "%m/%d/%Y") if val.present?
    write_attribute :ends_at, date
  end

  def ends_at_should_be_after_starts_from
    return if starts_from.blank? || ends_at.blank?

    if ends_at < starts_from
      errors.add :ends_at, "must be after the Starts from date"
    end
  end
end
