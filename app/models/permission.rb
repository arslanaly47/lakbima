class Permission < ApplicationRecord
  has_and_belongs_to_many :roles

  validates :subject_class, :action, presence: true

  def name
    [action.capitalize, subject_class.capitalize]*' '
  end
end
