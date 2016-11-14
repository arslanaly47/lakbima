class Ability
  include CanCan::Ability

  def initialize(user)
    user.role.permissions.each do |permission|
      if permission.subject_class == "all"
        can permission.action.downcase.to_sym, permission.subject_class.to_sym
      else
        can permission.action.downcase.to_sym, permission.subject_class.constantize
      end
    end
  end
end
