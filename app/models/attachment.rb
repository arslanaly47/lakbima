class Attachment < ApplicationRecord
  belongs_to :attachment_type
  belongs_to :attachable, polymorphic: true

  has_attached_file :image, styles: {
                              medium: "300x300>",
                              thumb: "100x100>"
                            }
  validates_associated :attachment_type
  validates_attachment_size :image, in: 0..20.megabytes
end
