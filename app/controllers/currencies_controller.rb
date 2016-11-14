class CurrenciesController < ApplicationController
  load_and_authorize_resource
  before_action :set_currency, only: [:edit, :update, :show, :destroy]

  def new
    @currency = Currency.new
  end

  def create
    @currency = Currency.new(currency_params)
    if @currency.save
      redirect_to @currency, notice: "Currency has successfully been saved."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @currency.update_attributes(currency_params)
      redirect_to @currency, notice: "Currency has successfully been updated."
    else
      render :edit
    end
  end

  def show
  end

  def index
    @currencies = Currency.all
  end

  def destroy
    @currency && @currency.destroy    
    respond_to do |format|
      flash.now[:notice] = "Currency: #{@currency.name} has been deleted." 
      format.js
    end
  end

  private

  def currency_params
    params.require(:currency).permit(:name, :code, :symbol, :country) 
  end

  def set_currency
    @currency = Currency.find(params[:id]) 
  end
end
