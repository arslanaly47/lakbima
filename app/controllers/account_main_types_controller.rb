class AccountMainTypesController < ApplicationController
  load_and_authorize_resource

  before_action :set_account_main_type, only: [:edit, :update, :show, :account_sub_types]

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

  def account_sub_headers
    status = ''
    @account_sub_types = @account_main_type.account_sub_types
    if @account_sub_types.blank?
      status = :not_found
    else
      @account_sub_type_names_and_ids = @account_main_type.account_sub_types.pluck(:name, :id)
      @account_sub_type_names_and_ids.unshift ["Please choose an account sub header.", ""]
      status = :ok
    end
    respond_to do |format|
      format.js { render status: status }
    end
  end

  private

  def account_main_type_params
    params.require(:account_main_type).permit(:description)
  end

  def set_account_main_type
    @account_main_type = AccountMainType.find(params[:id])
  end
end
