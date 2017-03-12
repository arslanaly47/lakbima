class NotificationUser < ApplicationRecord
  belongs_to :notification
  belongs_to :user

  scope :unread, -> { where(read: false) }
  scope :read,   -> { where(read: true)  }
end
