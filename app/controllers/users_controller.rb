class UsersController < ApplicationController
  skip_before_action :authenticate_and_check_user!
  before_action :authenticate_user!

  def edit
    @user = current_user
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

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation, :first_name, :last_name, :username, :phone_number, :address, :passport_no)
  end
end
