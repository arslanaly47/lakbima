class EmployeesController < ApplicationController
  load_and_authorize_resource except: [:index]

  before_action :set_employee, only: [:edit, :update, :show, :destroy, :download_attachment]
  helper_method :sort_column

  def new
    @employee = Employee.new
    set_departments
    set_job_titles
    set_salary
    set_vacation
    set_attachment
    set_attachment_types
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
      @employee.create_associated_user(params[:role_id])
      redirect_to @employee, notice: "Employee has successfully been saved."
    else
      set_departments
      set_job_titles
      set_salary
      render :new
    end
  end

  def edit
    set_departments
    set_job_titles
    set_salary
    set_attachment
    set_attachment_types
    @allowances = @employee.salary.try(:allowances)
  end

  def update
    if @employee.update_attributes(employee_params)    
      redirect_to @employee, notice: "Employee has successfully been updated."
    else
      set_departments
      set_job_titles
      set_salary
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

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :address, :phone_number, :nationality, :passport_no, :passport_expiry, :visa_no, :id_no, :visa_expiry, :medical_expiry, :job_title_id, :date_of_joining, :appointment_date, attachments_attributes: [:id, :attachment_type_id, :image, :_destroy], salary_attributes: [:id, :basic_salary, allowances_attributes: [:id, :allowance_type_id, :starts_from, :ends_at, :_destroy]], vacations_attributes: [:id, :vacation_type_id, :starts_from, :ends_at, :_destroy])
  end

  def set_employee
    @employee = Employee.find(params[:id]) 
  end

  def set_departments
    @departments = Department.all
  end

  def set_job_titles
    if @employee.job_title
      @job_titles = @employee.department.job_titles
    else
      @job_titles = @departments.first.try(:job_titles)
    end
  end

  def set_salary
    @employee.salary || @employee.build_salary
  end

  def set_vacation
    @employee.vacations.build
  end

  def set_attachment
    @employee.attachments.build
  end

  def set_attachment_types
    unallocated_ids = @employee.unallocted_attachment_type_ids
    @attachment_type_ids = AttachmentType.find unallocated_ids
  end

  def sort_column
    Employee.column_names.include?(params[:sort])? params[:sort] : "id"
  end
end
