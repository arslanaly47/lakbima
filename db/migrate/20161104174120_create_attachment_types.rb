class CreateAttachmentTypes < ActiveRecord::Migration[5.0]
  def change
    create_table :attachment_types do |t|
      t.string :name
      t.string :description

      t.timestamps
    end
  end
end
