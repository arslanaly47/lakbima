class EmployeesController < ApplicationController

  before_action :set_employee, only: [:edit, :update, :show, :destroy]

  def new
    @employee = Employee.new
    set_departments
    set_job_titles
    set_salary
  end

  def create
    @employee = Employee.new(employee_params)
    if @employee.save
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
    @employees = Employee.all
  end

  def destroy
    @employee && @employee.destroy    
    respond_to do |format|
      flash.now[:notice] = "Employee: #{@employee.full_name} has been deleted." 
      format.js
    end
  end

  private

  def employee_params
    params.require(:employee).permit(:first_name, :last_name, :email, :address, :phone_number, :username, :nationality, :passport_no, :passport_expiry, :visa_no, :id_no, :visa_expiry, :medical_expiry, :job_title, salary_attributes: [:id, :basic_salary, allowances_attributes: [:id, :allowance_type_id, :starts_from, :ends_at, :_destroy]])
  end

  def set_employee
    @employee = Employee.find(params[:id]) 
  end

  def set_departments
    @departments = Department.all
  end

  def set_job_titles
    @job_titles = @departments.first.try(:job_titles)
  end

  def set_salary
    @employee.salary || @employee.build_salary
  end
end
