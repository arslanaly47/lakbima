class CreateJobTitles < ActiveRecord::Migration[5.0]
  def change
    create_table :job_titles do |t|
      t.string :name
      t.string :description
      t.references :department, foreign_key: true, index: true

      t.timestamps
    end
  end
end
