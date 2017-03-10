class RemoveJobTiltleIdFromEmployees < ActiveRecord::Migration[5.0]
  def up
    remove_reference :employees, :job_title
  end
  def down
    add_reference :employees, :job_title, foreign_key: true, index: true
  end
end
