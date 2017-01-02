class AccountsController < ApplicationController
  load_and_authorize_resource

  before_action :set_account, only: [:edit, :update, :show, :destroy, :job_titles]
  helper_method :sort_column

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
    @account_sub_type = @account.account_sub_type
    @account_main_type = @account.account_main_type
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
    @accounts = Account.includes(:account_sub_type).order(sort_column + " " + sort_direction)
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
    params.require(:account).permit(:account_type_id, :name, :description, :opening_balance)
  end

  def set_account
    @account = Account.find(params[:id]) 
  end

  def sort_column
    Account.column_names.include?(params[:sort])? params[:sort] : "id"
  end
end
