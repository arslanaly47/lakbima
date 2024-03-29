class LeaveApplicationsController < ApplicationController
  load_and_authorize_resource

  before_action :set_leave_application, only: [:edit, :update, :show, :destroy, :job_titles, :approve, :deny]
  helper_method :sort_column

  def new
    @leave_application = current_user.leave_applications.new
  end

  def create
    @leave_application = current_user.leave_applications.new(leave_application_params)
    calculate_and_set_number_of_days
    if @leave_application.save
      @leave_application.create_associated_notification("applicant")
      # ActionCable.server.broadcast 'activity_channel', content: @leave_application.reason
      redirect_to @leave_application, notice: "Leave application has successfully been sent."
    else
      render :new
    end
  end

  def show
  end

  def index
    if current_user.manager?
      @leave_applications = LeaveApplication.all.order(sort_column + " " + sort_direction).filter_by_vacation_type(params)
    else
      @leave_applications = current_user.leave_applications.order(sort_column + " " + sort_direction).filter_by_vacation_type(params)
    end
    applicant_ids = LeaveApplication.all.map(&:user_id).uniq
    @applicants = User.find(applicant_ids)
  end

  def approve
    @leave_application.approved!
    @leave_application.update_attribute :manager_id, current_user.id
    @leave_application.create_associated_notification("action")
    if current_user.mark_notification(@leave_application.applicant_notification.id)
      render json: { read: true }
    else
      render json: { read: false }
    end
  end

  def deny
    @leave_application.denied!
    @leave_application.update_attribute :manager_id, current_user.id
    @leave_application.create_associated_notification("action")
    if current_user.mark_notification(@leave_application.applicant_notification.id)
      render json: { read: true }
    else
      render json: { read: false }
    end
  end

  private

  def leave_application_params
    params.require(:leave_application).permit(:vacation_type_id, :reason, :start_date, :end_date)
  end

  def set_leave_application
    if current_user.employee?
      @leave_application = current_user.leave_applications.find params[:id]
    elsif current_user.manager?
      @leave_application = LeaveApplication.find params[:id]
    end
  end

  def calculate_and_set_number_of_days
    if @leave_application.end_date.nil?
      @leave_application.number_of_days = 1
    elsif !@leave_application.start_date.nil? && !@leave_application.end_date.nil?
      @leave_application.number_of_days = (@leave_application.end_date - @leave_application.start_date).to_i + 1
    end
  end

  def sort_column
    LeaveApplication.column_names.include?(params[:sort])? params[:sort] : "id"
  end
end
