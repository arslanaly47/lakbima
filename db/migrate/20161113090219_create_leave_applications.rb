class CreateLeaveApplications < ActiveRecord::Migration[5.0]
  def change
    create_table :leave_applications do |t|
      t.references :user, foreign_key: true, index: true
      t.string :subject
      t.text :reason
      t.integer :number_of_days
      t.date :start_date
      t.date :end_date
      t.integer :manager_id, foreign_key: true, index: true
      t.string :action

      t.timestamps
    end
  end
end
