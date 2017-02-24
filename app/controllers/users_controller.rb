class UsersController < ApplicationController
  skip_before_action :authenticate_and_check_user!
  before_action :authenticate_user!
  before_action :set_user, only: [:edit, :update, :show]
  helper_method :sort_column

  def new
    @user = User.new
    @employees = Employee.all
    @roles = Role.all
  end

  def create
    @user = User.new(user_params)
    @user.set_random_password if params[:auto_generate] == "on"
    if @user.save
      redirect_to users_path, notice: "User has successfully been created in this branch."
    else
      @employees = Employee.all
      @roles = Role.all
      render :new
    end
  end

  def show
  end

  def edit
    @employees = Employee.all
    @roles = Role.all
  end

  def update
    if @user.update(user_params)
      redirect_to @user, notice: "User has successfully been updated."
    else
      @employees = Employee.all
      @roles = Role.all
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

  private

  def user_params
    params.require(:user).permit(:password, :first_name, :last_name, :username, :phone_number, :role_id, :employee_id, :address)
  end

  def sort_column
    User.column_names.include?(params[:sort])? params[:sort] : "id"
  end

  def set_user
    @user = User.find(params[:id])
  end
end
