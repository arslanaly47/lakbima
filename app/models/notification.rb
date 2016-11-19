class Notification < ApplicationRecord
  belongs_to :generator, class_name: "User", foreign_key: :user_id
  belongs_to :leave_application
  has_many :notification_users
  has_many :receivers, through: :notification_users, class_name: "User", source: :user

  default_scope { order('created_at DESC') }

  after_create :associate_it_with_concerned_people

  alias_method :sender, :generator

  def associate_it_with_concerned_people
    if self.generator.employee?
      User.managers.each { |manager| self.receivers << manager }
    elsif self.generator.manager?
      self.receivers << self.generator
    end
  end

  def leave_application_id
    leave_application.id
  end
end
