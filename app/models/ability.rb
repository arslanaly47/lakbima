class Ability
  include CanCan::Ability

  def initialize(user)
    user.role.permissions.each do |permission|
      if permission.subject_class.downcase == "all"
        can permission.action.downcase.to_sym, permission.subject_class.to_sym
      elsif permission.action.downcase == "manage"
        can permission.action.downcase.to_sym, permission.subject_class.constantize
      elsif permission.action.downcase == "create"
        can :new, permission.subject_class.constantize
        can permission.action.downcase.to_sym, permission.subject_class.constantize
      elsif permission.action.downcase == "update"
        can :edit, permission.subject_class.constantize
        can permission.action.downcase.to_sym, permission.subject_class.constantize
      elsif permission.action.downcase == "view"
        can :index, permission.subject_class.constantize
        can :show, permission.subject_class.constantize
        can permission.action.downcase.to_sym, permission.subject_class.constantize
      else
        can permission.action.downcase.to_sym, permission.subject_class.constantize
      end
    end
  end
end
