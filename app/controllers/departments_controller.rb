class DepartmentsController < ApplicationController

  before_action :set_department, only: [:edit, :update, :show, :destroy]

  def new
    @department = Department.new
  end

  def create
    @department = Department.new(department_params)
    if @department.save
      redirect_to @department, notice: "Department has successfully been saved."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @department.update_attributes(department_params)    
      redirect_to @department, notice: "Department has successfully been updated."
    else
      render :edit
    end
  end

  def show
  end

  def index
    @departments = Department.all
  end

  def destroy
    @department && @department.destroy    
    respond_to do |format|
      flash.now[:notice] = "Department: #{@department.name} has been deleted." 
      format.js
    end
  end

  private

  def department_params
    params.require(:department).permit(:name, :description) 
  end

  def set_department
    @department = Department.find(params[:id]) 
  end
end
