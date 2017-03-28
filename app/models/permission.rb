class Permission < ApplicationRecord
  has_and_belongs_to_many :roles

  validates :subject_class, :action, presence: true
  validates :subject_class, uniqueness: { scope: :action, message: "with this action already exists in the system." }

  def name
    [action.capitalize, subject_class.capitalize]*' '
  end
end
