class Notification < ApplicationRecord
  belongs_to :leave_application
  has_many :notification_users
  has_many :receivers, through: :notification_users, class_name: "User", source: :user

  validates :leave_application, :notification_type, presence: true

  default_scope { order('created_at DESC') }

  after_create :associate_it_with_concerned_people

  enum notification_type: [:applicant, :action]

  def associate_it_with_concerned_people
    if applicant?
      User.managers.each { |manager| self.receivers << manager }
    elsif action?
      self.receivers << leave_application.applicant
    end
  end

  def leave_application_id
    leave_application.id
  end

  def generator
    if applicant?
      leave_application.applicant
    elsif action?
      leave_application.manager
    end
  end

  def read_by?(user)
    notification_users.where(user: user, read: true).exists?
  end
end
