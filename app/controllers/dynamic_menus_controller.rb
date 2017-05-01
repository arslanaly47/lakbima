class DynamicMenusController < ApplicationController
  load_and_authorize_resource

  before_action :set_dynamic_menu, only: [:edit, :update, :show, :destroy]

  def new
    @dynamic_menu = DynamicMenu.new
    @dynamic_menu.dynamic_menus_from_account_types.build
    @to_account_types = AccountType.all
  end

  def create
    @dynamic_menu = DynamicMenu.new(dynamic_menu_params)
    if @dynamic_menu.save
      redirect_to @dynamic_menu, notice: "Dynamic Menu has successfully been saved."
    else
      @to_account_types = AccountType.all
      render :new
    end
  end

  def edit
    @to_account_types = @dynamic_menu.selectable_to_account_types
  end

  def update
    if @dynamic_menu.update_attributes(dynamic_menu_params)
      redirect_to @dynamic_menu, notice: "Account Type has successfully been updated."
    else
      @to_account_types = @dynamic_menu.selectable_to_account_types
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

  def to_account_type_ids
    from_account_type_ids = params[:from_account_type_ids].split(',')
    remaining_account_type_ids = AccountType.pluck(:id) - from_account_type_ids.map(&:to_i)
    ids_and_names = AccountType.find(remaining_account_type_ids).pluck(:id, :name)
    options = ""
    ids_and_names.each do |remaining_account_type|
      options << "<option value=\"#{remaining_account_type[0]}\">#{remaining_account_type[1]}</option>"
    end
    render json: { options: options }
  end

  def check_uniqueness_for_name
    if params[:currentName].empty?
      render json: { result: true }
    else
      result = DynamicMenu.uniq_name?(params[:currentName])
      render json: { result: result }
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
