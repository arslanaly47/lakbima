class RemoveSubjectFromLeaveApplications < ActiveRecord::Migration[5.0]
  def up
    remove_column :leave_applications, :subject
    add_reference :leave_applications, :vacation_type, foreign_key: true
  end
  def down
    add_column :leave_applications, :subject, :string
    remove_reference :leave_applications, :vacation_type
  end
end
