class LeaveApplicationsController < ApplicationController
  load_and_authorize_resource

  before_action :set_leave_application, only: [:edit, :update, :show, :destroy, :job_titles]

  def new
    @leave_application = current_user.leave_applications.new
  end

  def create
    @leave_application = current_user.leave_applications.new(leave_application_params)
    calculate_and_set_number_of_days
    if @leave_application.save
      redirect_to @leave_application, notice: "Leave application has successfully been sent."
    else
      render :new
    end
  end

  def show
  end

  def index
    @leave_applications = current_user.leave_applications
  end


  private

  def leave_application_params
    params.require(:leave_application).permit(:subject, :reason, :start_date, :end_date)
  end

  def set_leave_application
    @leave_application = current_user.leave_applications.find params[:id]
  end

  def calculate_and_set_number_of_days
    if @leave_application.end_date.nil?
      @leave_application.number_of_days = 1
    else
      @leave_application.number_of_days = (@leave_application.end_date - @leave_application.start_date).to_i
    end
  end
end
