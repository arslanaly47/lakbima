class AddJobTitleIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_reference :users, :job_title, foreign_key: true, index: true
  end
end
