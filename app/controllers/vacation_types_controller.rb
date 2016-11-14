class VacationTypesController < ApplicationController
  load_and_authorize_resource

  before_action :set_vacation_type, only: [:edit, :update, :show, :destroy]

  def new
    @vacation_type = VacationType.new
  end

  def create
    @vacation_type = VacationType.new(vacation_type_params)
    if @vacation_type.save
      redirect_to @vacation_type, notice: "Vacation type has successfully been saved."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @vacation_type.update_attributes(vacation_type_params)
      redirect_to @vacation_type, notice: "Vacation type has successfully been updated."
    else
      render :edit
    end
  end

  def show
  end

  def index
    @vacation_types = VacationType.all
  end

  def destroy
    @vacation_type && @vacation_type.destroy    
    respond_to do |format|
      flash.now[:notice] = "Vacation Type: #{@vacation_type.name} has been deleted." 
      format.js
    end
  end

  private

  def vacation_type_params
    params.require(:vacation_type).permit(:name, :description)
  end

  def set_vacation_type
    @vacation_type = VacationType.find(params[:id]) 
  end
end
