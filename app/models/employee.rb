class Employee < ApplicationRecord

  has_one :salary
  has_many :vacations
  has_many :attachments, as: :attachable
  belongs_to :job_title
  has_one :profile_image, -> { profile_image }, class_name: :Attachment, as: :attachable

  validates :username, presence: true, uniqueness: true
  validates_associated :job_title
  validate :attachment_types_should_be_unique

  NATIONALITIES = ["Sri Lanka", "India", "Nepal", "Phillippines"]
  accepts_nested_attributes_for :salary,
                                allow_destroy: true,
                                reject_if: proc { |attributes|
                                  attributes['basic_salary'].blank?
                                }
  accepts_nested_attributes_for :vacations,
                                allow_destroy: true,
                                reject_if: proc { |attributes|
                                  attributes['starts_from'].blank? ||
                                    attributes['ends_at'].blank?
                                }
  accepts_nested_attributes_for :attachments,
                                allow_destroy: true,
                                reject_if: proc { |attributes|
                                  attributes['image'].blank?
                                }


  delegate :department, to: :job_title, allow_nil: true
  delegate :applicable_allowances, to: :salary, allow_nil: true
  delegate :expired_allowances, to: :salary, allow_nil: true
  delegate :allowances, to: :salary, allow_nil: true

  def full_name
    [first_name, last_name]*" "
  end

  %w(passport_expiry visa_expiry medical_expiry appointment_date).each do |attribute|
    define_method "#{attribute}=" do |val|
      date = Date.strptime(val, "%m/%d/%Y") if val.present?
      write_attribute attribute.to_sym, date
    end
  end

  def department_name
    job_title.try(:department).try(:name)
  end

  def unallocted_attachment_type_ids
    allocated_ids = attachments.map(&:attachment_type_id)
    AttachmentType.ids - allocated_ids
  end

  def attachment_types_should_be_unique
     allocated_ids = attachments.map(&:attachment_type_id)
     unless allocated_ids.uniq.length == allocated_ids.length
       errors.add :base, "You can't upload an item for the same attachment type twice."
     end
  end
end
