require 'open-uri'

class EmployeePdf < Prawn::Document
  def initialize(employees)
    super(top_margin: 70, page_size: [1500,1500])
    @employees = employees
    text "All Employees."
    render_employees
  end

  def render_employees
    move_down 20
    table employee_table_data do
      row(0).font_style = :bold
      self.row_colors = ["DDDDDD", "FFFFFF"]
      self.header = true
    end
  end

  def employee_header
    ["Profile Image", "First Name", "Last Name", "Phone No.", "Visa Expiry", "Medical Expiry", "Passport Expiry", "Nationality", "Visa No."]
  end

  def employee_rows
    @employees.map do |employee|
      [{image: open(image_path_for_employee(employee))} ,employee.first_name, employee.last_name, employee.phone_number, employee.visa_expiry, employee.medical_expiry, employee.passport_expiry, employee.nationality, employee.visa_no]
    end
  end

  def image_path_for_employee(employee)
    if employee.profile_image.nil?
      "#{Rails.root}/app/assets/images/no-user-image.png"
    else
      employee.profile_image.image.url(:thumb)
    end
  end

  def employee_table_data
    [employee_header, *employee_rows]
  end
end
