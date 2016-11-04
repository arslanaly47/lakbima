class Vacation < ApplicationRecord
  belongs_to :employee
  belongs_to :vacation_type

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
      errors.add :ends_at, "must be after the 'starts from' date"
    end
  end
end
