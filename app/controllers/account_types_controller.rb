class AccountTypesController < ApplicationController
  load_and_authorize_resource

  before_action :set_account_type, only: [:edit, :update, :show, :destroy]

  def new
    @account_type = AccountType.new
  end

  def create
    @account_type = AccountType.new(account_type_params)
    if @account_type.save
      redirect_to @account_type, notice: "Account Type has successfully been saved."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @account_type.update_attributes(account_type_params)
      redirect_to @account_type, notice: "Account Type has successfully been updated."
    else
      render :edit
    end
  end

  def show
  end

  def index
    @account_types = AccountType.all
  end

  def destroy
    @account_type && @account_type.destroy
    respond_to do |format|
      flash.now[:notice] = "Account Type: #{@account_type.name} has been deleted."
      format.js
    end
  end


  private

  def account_type_params
    params.require(:account_type).permit(:account_sub_type_id, :name, :description)
  end

  def set_account_type
    @account_type = AccountType.find(params[:id])
  end
end
