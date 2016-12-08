class AccountMainTypesController < ApplicationController
  load_and_authorize_resource

  before_action :set_account_main_type, only: [:edit, :update, :show]

  def edit
  end

  def update
    if @account_main_type.update_attributes(account_main_type_params)
      redirect_to @account_main_type, notice: "Account has successfully been updated."
    else
      render :edit
    end
  end

  def show
  end

  def index
    @account_main_types = AccountMainType.all
  end

  private

  def account_main_type_params
    params.require(:account_main_type).permit(:description)
  end

  def set_account_main_type
    @account_main_type = AccountMainType.find(params[:id])
  end
end
