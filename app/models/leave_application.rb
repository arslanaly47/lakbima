class LeaveApplication < ApplicationRecord
  belongs_to :user
  belongs_to :manager, class_name: "User"
  belongs_to :vacation_type

  has_one :notification

  validates :start_date, :number_of_days, :reason, presence: true
  validates_associated :vacation_type
  validate :end_date_should_be_after_start_date
  validate :not_before_today_date, on: :create

  after_create :create_associated_notification

  enum status: [:pending, :approved, :denied]

  def start_date=(val)
    date = Date.strptime(val, "%m/%d/%Y") if val.present?
    write_attribute :start_date, date
  end

  def end_date=(val)
    date = Date.strptime(val, "%m/%d/%Y") if val.present?
    write_attribute :end_date, date
  end

  def end_date_should_be_after_start_date
    return if start_date.blank? || end_date.blank?

    if end_date < start_date
      errors.add :end_date, "must be after the 'start date'"
    end
  end

  def not_before_today_date
    if (start_date && start_date < Date.today) || (end_date && end_date < Date.today)
      errors.add :base, "dates shouldn't be in past."
    end
  end

  def create_associated_notification
    content = "applied for a #{number_of_days} day leave."
    Notification.create(content: content, generator: user, leave_application: self)
  end
end
