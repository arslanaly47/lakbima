class AttachmentTypesController < ApplicationController
  load_and_authorize_resource

  before_action :set_attachment_type, only: [:edit, :update, :show, :destroy]

  def new
    @attachment_type = AttachmentType.new
  end

  def create
    @attachment_type = AttachmentType.new(attachment_type_params)
    if @attachment_type.save
      redirect_to @attachment_type, notice: "Attachment type has successfully been saved."
    else
      render :new
    end
  end

  def edit
  end

  def update
    if @attachment_type.update_attributes(attachment_type_params)
      redirect_to @attachment_type, notice: "Attachment type has successfully been updated."
    else
      render :edit
    end
  end

  def show
  end

  def index
    @attachment_types = AttachmentType.all
  end

  def destroy
    @attachment_type && @attachment_type.destroy
    respond_to do |format|
      flash.now[:notice] = "Attachment Type: #{@attachment_type.name} has been deleted."
      format.js
    end
  end

  private

  def attachment_type_params
    params.require(:attachment_type).permit(:name, :description)
  end

  def set_attachment_type
    @attachment_type = AttachmentType.find(params[:id])
  end
end
