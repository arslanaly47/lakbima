class RolesController < ApplicationController

  before_action :set_role, only: [:show, :edit, :update, :destroy]

  def new
    @role = Role.new
    @permissions = Permission.all
  end
  
  def index
    @roles = Role.all
  end

  def create
   @role = Role.new(role_params)  

   if @role.save
     redirect_to @role, notice: "Role has successfully been saved."
   else
     render :new
   end
  end

  def edit
    @permissions = Permission.all
  end

  def update
    if @role.update_attributes(role_params)    
      redirect_to @role, notice: "Role has successfully been updated."
    else
      render :edit
    end
  end

  def destroy
    @role && @role.destroy    
    respond_to do |format|
      flash.now[:notice] = "Employee: #{@role.name} has been deleted." 
      format.js
    end
  end

  private

  def role_params
    params.require(:role).permit(:name, :description, permission_ids: [])
  end

  def set_role
    @role = Role.find_by_id(params[:id])
  end
end
