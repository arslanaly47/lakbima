class BranchesController < ApplicationController
  load_and_authorize_resource

  before_action :set_branch, only: [:edit, :update, :show, :destroy]

  def new
    @branch = Branch.new
  end

  def create
    @branch = Branch.new(branch_params)
    if @branch.save
      redirect_to @branch, notice: "Branch has successfully been saved."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @branch.update_attributes(branch_params)
      redirect_to @branch, notice: "Branch has successfully been updated."
    else
      render :edit
    end
  end

  def show
  end

  def index
    @branches = Branch.all
  end

  def destroy
    @branch && @branch.destroy
    respond_to do |format|
      flash.now[:notice] = "Branch: #{@branch.name} has been deleted."
      format.js
    end
  end


  private

  def branch_params
    params.require(:branch).permit(:name, :address, :description)
  end

  def set_branch
    @branch = Branch.find_by_id(params[:id])
  end
end
