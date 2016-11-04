class CreateAttachments < ActiveRecord::Migration[5.0]
  def change
    create_table :attachments do |t|
      t.boolean :verified
      t.references :attachment_type, foreign_key: true
      t.references :attachable, polymorphic: true

      t.timestamps
    end
  end
end
