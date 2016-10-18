namespace :permissions do
  desc "Loading all models and their related controller methods in permissions table."
  task(permissions: :environment) do
    arr = []
    # Load all the controllers
    controllers = Dir.new("#{Rails.root}/app/controllers").entries
    controllers.each do |entry| 
      if entry =~ /_controller/
        # Check if the controller is valid
        arr << entry.camelize.gsub('.rb', '').constantize
      elsif entry =~ /^[a-z]*$/ # Namespaced controllers
        Dir.new("#{Rails.root}/app/controllers/#{entry}").entries.each do |sub_entry|
          arr << "#{entry.titleize}::#{sub_entry.camelize.gsub('.rb', '')}" 
        end
      end
    end

    arr.each do |controller|
      # Only that controller which represents a model
      if controller.permission
        # Create a universal permission for that model.
        write_permission(controller.permission, "manage", "manage")
        controller.action_methods.each do |method|
          if method =~ /^([A-Za-z\d*]+)+([\w]*)+([A-Za-z\d*]+)$/
            name, cancancan_action = eval_cancancan_action(method)
            write_permission(controller.permission, cancancan_action, name)
          end
        end
      end
    end
  end
end

# This method returns the cancancan action for the action passed.

def eval_cancancan_action(action)
  case action.to_s 
    when "index"
      name = "list"
      cancancan_action = "index"
      action_desc = I18n.t :list
    when "new", "create"
      name = "create and update"
      cancancan_action = "create"
      action_desc = I18n.t :create
    when "show"
      name = "view"
      cancancan_action = "view"
      action_desc = I18n.t :view
    when "edit", "update"
      name = "create and update"
      cancancan_action = "update"
      action_desc = I18n.t :update
    when "delete", "destroy"
      name = "delete"
      cancancan_action = "destroy"
      action_desc = I18n.t :destroy
    else
      name = action.to_s
      cancancan_action = action.to_s
      action_desc = "Other: " < cancancan_action
  end
  return name, cancancan_action
end

# Check if the permission is present, otherwise add a new one.

def write_permission(model, cancancan_action, name)
  permission = Permission.find_by(subject_calss: model, action: cancancan_action)
  unless permission
    Permission.create(name: name, subject_class: model, action: cancancan_action)
  end
end
