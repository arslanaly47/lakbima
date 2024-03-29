class UsersController < ApplicationController
  skip_before_action :authenticate_and_check_user!
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update, :show, :terminate, :unterminate]
  helper_method :sort_column

  def new
    @user = User.new
    @employees = Employee.all.sort_by(&:full_name)
    @roles = Role.all
    set_salary
    set_departments
    set_job_titles
  end

  def create
    @user = User.new(user_params)
    if params[:auto_generate] == "on"
      @user.set_random_password
    else
      @user.temp_password = params[:user][:password]
    end
    if @user.save
      redirect_to users_path, notice: "User has successfully been created in this branch."
    else
      @employees = Employee.all.sort_by(&:full_name)
      @roles = Role.all
      set_salary
      set_departments
      set_job_titles
      render :new
    end
  end

  def show
  end

  def edit
    @employees = Employee.all.sort_by(&:full_name)
    @roles = Role.all
    set_salary
    set_departments
    set_job_titles
  end

  def update
    determine_password
    if @user.update(user_params)
      redirect_to @user, notice: "User has successfully been updated."
    else
      @employees = Employee.all.sort_by(&:full_name)
      @roles = Role.all
      set_salary
      set_departments
      set_job_titles
      render :edit
    end
  end

  def change_password
    @user = current_user
  end

  def index
    @users = User.order(sort_column + " " + sort_direction)
  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update(user_params.merge temp_password_changed: true)
      bypass_sign_in @user
      redirect_to root_path, notice: "Password has successfully been reset."
    else
      render :edit
    end
  end

  def profile
    @user = current_user
  end

  def update_profile
    @user = User.find(current_user.id)
    if @user.update(user_params)
      redirect_to root_path, notice: "Your profile has successfully been updated."
    else
      render :edit
    end
  end

  def check_uniqueness
    if params[:username].empty?
      render json: { result: false }
    else
      result = User.uniq_username?(params[:username])
      render json: { result: result }
    end
  end

  def terminate
    @user.terminate!
    render json: { success: true }
  end

  def unterminate
    @user.unterminate!
    render json: { success: true }
  end

  private

  def user_params
    params.require(:user).permit(:password, :first_name, :last_name, :username, :phone_number, :role_id, :employee_id, :address, :future, :date_of_joining, :job_title_id, salary_attributes: [:id, :basic_salary, allowances_attributes: [:id, :allowance_type_id, :starts_from, :ends_at, :_destroy]])
  end

  def set_departments
    @departments = Department.all
  end

  def set_job_titles
    if @user.job_title
      @job_titles = @user.department.job_titles
    else
      @job_titles = @departments.first.try(:job_titles)
    end
  end

  def sort_column
    User.column_names.include?(params[:sort])? params[:sort] : "id"
  end

  def set_user
    @user = User.find(params[:id])
  end

  def set_salary
    @user.salary || @user.build_salary
  end

  def determine_password
    password = params[:user][:password]
    unless password.nil? || password.empty?
      @user.password = password
    end
    params[:user].delete :password
  end
end
