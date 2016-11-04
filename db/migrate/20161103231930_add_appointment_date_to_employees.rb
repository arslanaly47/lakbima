class AddAppointmentDateToEmployees < ActiveRecord::Migration[5.0]
  def change
    add_column :employees, :appointment_date, :date
  end
end
