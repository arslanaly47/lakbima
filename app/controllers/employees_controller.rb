class EmployeesController < ApplicationController
  load_and_authorize_resource except: [:index]

  before_action :set_employee, only: [:edit, :update, :show, :destroy, :download_attachment]
  helper_method :sort_column

  def new
    @employee = Employee.new
    set_vacation
    set_attachment
    set_attachment_types
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      redirect_to @employee, notice: "Employee has successfully been saved."
    else
      render :new
    end
  end

  def edit
    set_attachment
    set_attachment_types
  end

  def update
    if @employee.update_attributes(employee_params)
      redirect_to @employee, notice: "Employee has successfully been updated."
    else
      render :edit
    end
  end

  def show
  end

  def index
    @employees = Employee.includes(:profile_image).order(sort_column + " " + sort_direction)
  end

  def destroy
    @employee && @employee.destroy    
    respond_to do |format|
      flash.now[:notice] = "Employee: #{@employee.full_name} has been deleted." 
      format.js
    end
  end

  def download_attachment
    attachment = @employee.attachments.find_by_id params[:attachment_id]
    if attachment
      data = open(attachment.image.url)
      send_data data.read, type: attachment.image_content_type, x_sendfile: true,
        url_based_filename: true, disposition: "attachment"
    else
    end
  end

  def download_pdf
    @employees = Employee.get_pdf_report(sort_column, sort_direction)
    respond_to do |format|
      format.pdf do
        pdf = EmployeePdf.new(@employees)
        send_data pdf.render, filename: "all_employees", type: "application/pdf"
      end
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :address, :phone_number, :passport_no, :passport_expiry, :nationality, :visa_no, :id_no, :visa_expiry, :medical_expiry, :date_of_joining, :appointment_date, attachments_attributes: [:id, :attachment_type_id, :image, :_destroy], vacations_attributes: [:id, :vacation_type_id, :starts_from, :ends_at, :_destroy])
  end

  def set_employee
    @employee = Employee.find(params[:id]) 
  end

  def set_vacation
    @employee.vacations.build
  end

  def set_attachment
    @employee.attachments.build
  end

  def set_attachment_types
    unallocated_ids = @employee.unallocted_attachment_type_ids
    @attachment_type_names_and_ids = AttachmentType.find(unallocated_ids).pluck(:name, :id)
  end

  def sort_column
    Employee.column_names.include?(params[:sort])? params[:sort] : "id"
  end
end
