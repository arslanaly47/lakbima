class Attachment < ApplicationRecord
  belongs_to :attachment_type
  belongs_to :attachable, polymorphic: true

  has_attached_file :image, styles: {
                              medium: "300x300>",
                              thumb: "70x70>"
                            }
  validates_associated :attachment_type
  validates_attachment_size :image, in: 0..20.megabytes
  do_not_validate_attachment_file_type :image

  scope :profile_image, -> {
    joins(:attachment_type).where("attachment_types.name = ?", 'Profile Photo')
  }
end
