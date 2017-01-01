class AccountSubTypesController < ApplicationController
  load_and_authorize_resource

  before_action :set_account_sub_type, only: [:edit, :update, :show, :destroy, :account_lists]

  def new
    @account_sub_type = AccountSubType.new
  end

  def create
    @account_sub_type = AccountSubType.new(account_sub_type_params)
    if @account_sub_type.save
      redirect_to @account_sub_type, notice: "Account Sub Type has successfully been saved."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @account_sub_type.update_attributes(account_sub_type_params)
      redirect_to @account_sub_type, notice: "Account Sub Type has successfully been updated."
    else
      render :edit
    end
  end

  def show
  end

  def index
    @account_sub_types = AccountSubType.all
  end

  def destroy
    @account_sub_type && @account_sub_type.destroy
    respond_to do |format|
      flash.now[:notice] = "Account Sub Type: #{@account_sub_type.name} has been deleted."
      format.js
    end
  end

  def account_lists
    status = ''
    if @account_sub_type.account_types.blank?
      status = :not_found
    else
      @account_list_names_and_ids = @account_sub_type.account_types.pluck(:name, :id)
      status = :ok
    end
    respond_to do |format|
      format.js { render status: status }
    end
  end

  private

  def account_sub_type_params
    params.require(:account_sub_type).permit(:account_main_type_id, :name, :description)
  end

  def set_account_sub_type
    @account_sub_type = AccountSubType.find(params[:id])
  end
end
