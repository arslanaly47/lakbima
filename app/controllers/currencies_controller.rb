class CurrenciesController < ApplicationController
  load_and_authorize_resource
  before_action :set_currency, only: [:edit, :update, :show, :destroy, :set_default]
  helper_method :sort_column

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
    @currencies = Currency.order(sort_column + " " + sort_direction)
  end

  def destroy
    @currency && @currency.destroy    
    respond_to do |format|
      flash.now[:notice] = "Currency: #{@currency.name} has been deleted." 
      format.js
    end
  end

  def set_default
    Currency.unset_default
    @currency.update_attribute(:default, true)
    render json: { default_currency_name: @currency.name }
  end

  def default
    @currency_names_and_ids = Currency.pluck(:name, :id)
    @default_currency_id    = Currency.default.try(:first).try(:id)
    @default_currency_name  = Currency.default.try(:first).try(:name) || "Not selected yet!"
  end

  private

  def currency_params
    params.require(:currency).permit(:name, :code, :symbol, :country) 
  end

  def set_currency
    @currency = Currency.find(params[:id]) 
  end

  def sort_column
    Currency.column_names.include?(params[:sort])? params[:sort] : "id"
  end
end
