class RemoveActionColumnFromLeaveApplications < ActiveRecord::Migration[5.0]
  def up
    remove_column :leave_applications, :action
    add_column :leave_applications, :status, :integer, default: 0
  end

  def down
    remove_column :leave_applications, :status
    add_column :leave_applications, :action, :string
  end
end
