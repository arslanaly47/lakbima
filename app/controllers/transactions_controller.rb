class TransactionsController < ApplicationController
  load_and_authorize_resource

  before_action :set_dynamic_menu, only: [:new, :create, :edit, :update, :show, :destroy, :index]
  before_action :set_transaction, only: [:create, :edit, :update, :show, :destroy]

  def new
    @transaction = @dynamic_menu.transactions.new
  end

  def create
    @transaction = @dynamic_menu.transactions.build(transaction_params)
    @transaction.user = current_user
    if @transaction.save
      redirect_to [@dynamic_menu, @transaction], notice: "Transaction has successfully been saved."
    else
      render :new
    end
  end

  def edit
  end

  def update
    @transaction.user = current_user
    if @transaction.update_attributes(transaction_params)
      redirect_to [@dynamic_menu, @transaction], notice: "Transaction has successfully been updated."
    else
      render :edit
    end
  end

  def show
  end

  def index
    @transactions = @dynamic_menu.transactions
  end

  def destroy
    @transaction && @transaction.destroy
    respond_to do |format|
      flash.now[:notice] = "Transaction: #{@transaction.name} has been deleted."
      format.js
    end
  end


  private

  def transaction_params
    params.require(:transaction).permit(:from_account_id, :to_account_id, :amount, :happened_at, :description)
  end

  def set_dynamic_menu
    @dynamic_menu = DynamicMenu.find(params[:dynamic_menu_id])
  end

  def set_transaction
    @transaction = @dynamic_menu.transactions.find_by(transactions: { id: params[:id]  })
  end
end
