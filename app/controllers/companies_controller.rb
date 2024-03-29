class CompaniesController < ApplicationController
  load_and_authorize_resource

  before_action :redirect_if_subdomain_not_www
  before_action :set_company, only: [:edit, :update, :show, :destroy]
  helper_method :sort_column

  include ApplicationHelper

  def new
    @company = Company.new
  end

  def create
    @company = Company.new(company_params)
    if @company.save
      redirect_to @company, notice: "Company has successfully been saved."
    else
      render :new
    end
  end

  def edit
  end

  def update
    old_subdomain =  @company.subdomain
    should_tenant_be_updated = @company.subdomain_changed?
    if @company.update_attributes(company_params)
      update_tenant_info(old_subdomain) if should_tenant_be_updated
      redirect_to @company, notice: "Company has successfully been updated."
    else
      render :edit
    end
  end

  def show
  end

  def index
    @company = Company.all.order(sort_column + " " + sort_direction)
  end

  private
  def company_params
    params.require(:company).permit(:business_name, :other_names, :address, :telephone, :mobile, :commercial_registration_no, :commercial_registration_expiry, :municipality_registration_no, :municipality_registration_expiry, :subdomain)
  end

  def set_company
    @company = Company.find(params[:id])
  end

  def sort_column
    Company.column_names.include?(params[:sort])? params[:sort] : "id"
  end

  def update_tenant_info(old_subdomain)
    @company.rename_tenant(old_subdomain)
  end

  def sort_column
    Company.column_names.include?(params[:sort])? params[:sort] : "id"
  end

  def redirect_if_subdomain_not_www
    unless current_subdomain_www?
      redirect_to root_url
    end
  end
end
