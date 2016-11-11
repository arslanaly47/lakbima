class UsersController < ApplicationController
  skip_before_action :authenticate_and_check_user!
  before_action :authenticate_user!

  def edit
    @user = current_user
  end

  def update_password
    @user = User.find(current_user.id)
    if @user.update(user_params)
      @user.temp_password_changed = true
      @user.save
      redirect_to root_path
    else
      render :edit
    end
  end

  private

  def user_params
    params.require(:user).permit(:password, :password_confirmation)
  end
end
