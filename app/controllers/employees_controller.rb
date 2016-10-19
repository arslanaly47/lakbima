class EmployeesController < ApplicationController

  before_action :set_employee, only: [:edit, :update, :show, :destroy]

  def new
    @employee = Employee.new
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
    params.require(:employee).permit(:first_name, :last_name, :email, :address, :phone_number, :username) 
  end

  def set_employee
    @employee = Employee.find(params[:id]) 
  end
end
