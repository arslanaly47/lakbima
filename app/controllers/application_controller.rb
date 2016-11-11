class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  before_action :authenticate_and_check_user!
  before_action :configure_permitted_paramters, if: :devise_controller?

  protected

  # Derive the model name from the controller
  def self.permission
    self.name.gsub('Controller', '').singularize.split('::').last.constantize.name rescue nil
  end

  def current_ability
    @current_ability ||= Ability.new(current_user)
  end

  # Load the permissions for the current user so that UI can be manipulated
  def load_permissions
    @current_permission = current_user.role.permissions.collect do |permission| 
      [permission.subject_class, permission.action]
    end
  end

  def configure_permitted_paramters
    added_attrs = [:login, :password, :remember_me]
    devise_parameter_sanitizer.permit :sign_in, keys: added_attrs
    devise_parameter_sanitizer.permit :account_update, keys: [:password, :password_confirmation]
  end

  def authenticate_and_check_user!
    authenticate_user!
    if current_user && !current_user.temp_password_changed?
      redirect_to edit_user_path
    end
  end
end
