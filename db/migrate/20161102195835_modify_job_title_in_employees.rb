class ModifyJobTitleInEmployees < ActiveRecord::Migration[5.0]
  def up
    remove_column :employees, :job_title
    add_reference :employees, :job_title, foreign_key: true, index: true
  end
  def down
    remove_reference :employees, :job_title
    add_column :employees, :job_title, :string
  end
end
