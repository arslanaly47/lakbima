class AccountsController < ApplicationController
  load_and_authorize_resource

  before_action :set_account, only: [:edit, :update, :show, :destroy, :job_titles]

  def new
    @account = Account.new
  end

  def create
    @account = Account.new(account_params)
    if @account.save
      redirect_to @account, notice: "Account has successfully been saved."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @account.update_attributes(account_params)
      redirect_to @account, notice: "Account has successfully been updated."
    else
      render :edit
    end
  end

  def show
  end

  def index
    @accounts = Account.includes(:account_sub_type).all
  end

  def destroy
    @account && @account.destroy    
    respond_to do |format|
      flash.now[:notice] = "Account: #{@account.name} has been deleted." 
      format.js
    end
  end


  private

  def account_params
    params.require(:account).permit(:account_sub_type_id, :name, :description)
  end

  def set_account
    @account = Account.find(params[:id]) 
  end
end
