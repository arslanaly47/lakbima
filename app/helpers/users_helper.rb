module UsersHelper
  def get_class_for_user(user)
    return "current-users" if user.current?
    return "future-users"  if user.future?
    return "past-users"    if user.terminated?
  end
end
