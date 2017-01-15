class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable and :omniauthable
  devise :database_authenticatable,
         :recoverable, :rememberable, :trackable, :validatable

  # Virtual attribute for authenticating by either username of email
  # This is in addition to a real persisted field like 'username'
  attr_accessor :login

  belongs_to :role
  has_one :employee
  has_one :active_journal_entry_session, -> { active }, class_name: "JournalEntrySession"
  has_many :notification_users
  has_many :read_notification_users,   -> { read },   class_name: "NotificationUser"
  has_many :unread_notification_users, -> { unread }, class_name: "NotificationUser"

  has_many :received_notifications, through: :notification_users,
                                    class_name: "Notification",
                                    source: :notification
  has_many :unread_notifications,   through: :unread_notification_users,
                                    class_name: "Notification",
                                    source: :notification
  has_many :read_notifications,     through: :notification_users,
                                    class_name: "Notification",
                                    source: :notification
  has_many :leave_applications
  has_many :journal_entry_sessions

  validates :role, :username, presence: true
  validates :username, uniqueness: true

  scope :managers,  -> { where(role: Role.find_by(name: "Manager")) }
  scope :employees, -> { where(role: Role.find_by(name: "Employee")) }

  delegate :profile_image, to: :employee, allow_nil: true

  accepts_nested_attributes_for :employee

  def full_name 
    [first_name, last_name]*' '
  end

  def full_name_with_role
    full_name = [first_name, last_name]*''
    "#{full_name} (#{role.name})"
  end

  def unread_notifications_count
    unread_notifications.count
  end

  def has_notifications_to_read?
    !unread_notifications.blank?
  end

  def self.uniq_username?(username)
    !User.find_by_username(username)
  end

  # Devise override
  def email_required?
    false
  end

  def temp_password_changed?
    temp_password_changed
  end

  # Allowing login through either email or username in devise
  def self.find_for_database_authentication(warden_conditions)
    conditions = warden_conditions.dup
    if login = conditions.delete(:login)
      where(conditions.to_h).where(["lower(username) = :value OR lower(email) = :value", { :value => login.downcase }]).first
    elsif conditions.has_key?(:username) || conditions.has_key?(:email)
      where(conditions.to_h).first
    end
  end

  def manager?
    role.name == "Manager"
  end

  def employee?
    role.name == "Employee"
  end

  def mark_notification(notification_id, read=true)
    notification_user = self.notification_users.find_by(notification_id: notification_id)
    if notification_user
      notification_user.update_attribute(:read, true)
      true
    else
      false
    end
  end

  def has_active_journal_entry_session?
    journal_entry_sessions.any? &:active?
  end
end
