class AllowanceTypesController < ApplicationController
  load_and_authorize_resource

  before_action :set_allowance_type, only: [:edit, :update, :show, :destroy]

  def new
    @allowance_type = AllowanceType.new
    set_currencies
  end

  def create
    @allowance_type = AllowanceType.new(allowance_type_params)
    if @allowance_type.save
      redirect_to @allowance_type, notice: "Allowance type has successfully been saved."
    else
      set_currencies
      render :new
    end
  end

  def edit
    set_currencies
  end

  def update
    if @allowance_type.update_attributes(allowance_type_params)
      redirect_to @allowance_type, notice: "Allowance type has successfully been updated."
    else
      set_currencies
      render :edit
    end
  end

  def show
  end

  def index
    @allowance_types = AllowanceType.all
  end

  def destroy
    @allowance_type && @allowance_type.destroy    
    respond_to do |format|
      flash.now[:notice] = "Allowance Type: #{@allowance_type.name} has been deleted." 
      format.js
    end
  end

  private

  def allowance_type_params
    params.require(:allowance_type).permit(:name, :description, :lump_sum_amount, :currency_id) 
  end

  def set_allowance_type
    @allowance_type = AllowanceType.find(params[:id]) 
  end

  def set_currencies
    @currencies = Currency.all
  end
end
