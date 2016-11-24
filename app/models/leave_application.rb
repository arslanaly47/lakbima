class LeaveApplication < ApplicationRecord

  has_one :applicant_notification, -> { applicant }, class_name: "Notification"
  has_one :action_notification,    -> { action }, class_name: "Notification"

  belongs_to :applicant, class_name: "User", foreign_key: :user_id
  belongs_to :manager, class_name: "User"
  belongs_to :vacation_type

  validates :start_date, :number_of_days, :reason, presence: true
  validates_associated :vacation_type
  validates_associated :applicant # Manager is assigned when a leave application is approved
                                  # or rejected.
  validate :end_date_should_be_after_start_date
  validate :not_before_today_date, on: :create

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

  def create_associated_notification(type)
    if type == "applicant"
      content = "applied for a #{number_of_days} day leave."
    elsif type == "action"
      if self.approved?
        content = "Your leave application has been approved"
      else
        content = "Your leave application has been denied"
      end
    end
    Notification.create(content: content, leave_application: self, notification_type: type)
  end
end
