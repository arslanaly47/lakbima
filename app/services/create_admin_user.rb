class CreateAdminUser
  def call
    employee = Employee.find_or_create_by(first_name: "Admin", last_name: "User")
    user = User.new(username: "admin_user", employee: employee, password: "password&123")
    SeedPermissionsForManager.new.call
    role = Role.create(name: "Manager", permissions: Permission.all)
    user.role = role
    user.save
    SeedNewTenant.new.call
  end
end
