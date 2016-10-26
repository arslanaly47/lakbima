class Department < ApplicationRecord
  has_many :job_titles
  validates :name, :description, presence: true
  validates :name, uniqueness: true
end
