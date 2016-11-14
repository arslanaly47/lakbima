class JobTitlesController < ApplicationController
  load_and_authorize_resource

  before_action :set_job_title, only: [:edit, :update, :show, :destroy]
  before_action :set_departments, only: [:new, :edit]

  def new
    @job_title = JobTitle.new
  end

  def create
    @job_title = JobTitle.new(job_title_params)
    if @job_title.save
      redirect_to @job_title, notice: "Job title has successfully been saved."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @job_title.update_attributes(job_title_params)    
      redirect_to @job_title, notice: "Job title has successfully been updated."
    else
      render :edit
    end
  end

  def show
  end

  def index
    @job_title = JobTitle.all
  end

  def destroy
    @job_title && @job_title.destroy    
    respond_to do |format|
      flash.now[:notice] = "Job title: #{@job_title.name} has been deleted." 
      format.js
    end
  end

  private

  def job_title_params
    params.require(:job_title).permit(:name, :description, :department_id) 
  end

  def set_job_title
    @job_title = JobTitle.find(params[:id]) 
  end

  def set_departments
    @departments = Department.all
  end
end
