class Notification < ApplicationRecord
  belongs_to :generator, class_name: 'User', foreign_key: :user_id
  has_many :notification_users
  has_many :users, through: :notification_users
end
