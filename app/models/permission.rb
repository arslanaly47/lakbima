class Permission < ApplicationRecord
  has_and_belongs_to_many :roles

  def name
    [action, subject_class]*' '
  end
end
