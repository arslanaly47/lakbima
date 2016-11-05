class AddImageToAttachments < ActiveRecord::Migration[5.0]
  def change
    add_attachment :attachments, :image
  end
end
