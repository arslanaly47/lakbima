class DynamicMenusController < ApplicationController
  load_and_authorize_resource

  before_action :set_dynamic_menu, only: [:edit, :update, :show, :destroy]

  def new
    @dynamic_menu = DynamicMenu.new
  end

  def create
    @dynamic_menu = DynamicMenu.new(dynamic_menu_params)
    if @dynamic_menu.save
      redirect_to @dynamic_menu, notice: "Dynamic Menu has successfully been saved."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @dynamic_menu.update_attributes(dynamic_menu_params)
      redirect_to @account_type, notice: "Account Type has successfully been updated."
    else
      render :edit
    end
  end

  def show
  end

  def index
    @dynamic_menus = DynamicMenu.all
  end

  def destroy
    @dynamic_menu && @dynamic_menu.destroy
    respond_to do |format|
      flash.now[:notice] = "Dynamic Menu: #{@dynamic_menu.name} has been deleted."
      format.js
    end
  end


  private

  def dynamic_menu_params
    params.require(:dynamic_menu).permit(:name, :description, from_account_type_ids: [], to_account_type_ids: [])
  end

  def set_dynamic_menu
    @dynamicMenu = DynamicMenu.find(params[:id])
  end
end
