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
  has_many :notification_users
  has_many :read_notification_users,   -> { read },   class_name: "NotificationUser"
  has_many :unread_notification_users, -> { unread }, class_name: "NotificationUser"

  has_many :notifications,        through: :notification_users
  has_many :unread_notifications, through: :unread_notification_users,
                                  class_name: "Notification",
                                  source: :notification
  has_many :read_notifications,   through: :notification_users,
                                  class_name: "Notification",
                                  source: :notification
  validates :role, :username, presence: true
  validates :username, uniqueness: true

  delegate :profile_image, to: :employee

  def full_name
    [first_name, last_name]*' '
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
end
