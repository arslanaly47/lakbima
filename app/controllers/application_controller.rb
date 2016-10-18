class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception


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
end
