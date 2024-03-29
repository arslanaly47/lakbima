class TransactionsController < ApplicationController
  load_and_authorize_resource

  before_action :set_dynamic_menu, only: [:new, :create, :edit, :update, :show, :destroy, :index]
  before_action :set_transaction, only: [:create, :edit, :update, :show, :destroy]

  def new
    @transaction = @dynamic_menu.transactions.new
    @transaction.attachments.build
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
    @transaction.attachments.build
  end

  def update
    @transaction.user = current_user
    if @transaction.update_attributes(transaction_params)
      respond_to do |format|
        format.html { redirect_to [@dynamic_menu, @transaction], notice: "Transaction has successfully been updated."
 }
        format.js { flash.now[:notice] = "Transaction has successfully been updated."  }
      end
    else
      respond_to do |format|
        format.html { render :edit }
        format.js
      end
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

  def shift_summary
    date = params[:date_for_transaction] || Date.today
    @transactions = Transaction.where(happened_at: date)
  end

  private

  def transaction_params
    params.require(:transaction).permit(:from_account_id, :to_account_id, :amount, :happened_at, :description, attachments_attributes: [:id, :image, :_destroy])
  end

  def set_dynamic_menu
    @dynamic_menu = DynamicMenu.find(params[:dynamic_menu_id])
  end

  def set_transaction
    @transaction = @dynamic_menu.transactions.find_by(transactions: { id: params[:id]  })
  end
end
