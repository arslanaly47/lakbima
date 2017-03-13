class SeedNewTenant
  def call
    create_header_accounts
    create_common_permissions
    create_employee_role
  end

  private
  def create_header_accounts
    AccountMainType.create(name: "Assets",      description: "Something owned or controlled by an entity")
    AccountMainType.create(name: "Liabilities", description: "Economic obligations of an entity.")
    AccountMainType.create(name: "Equity",      description: "The value of assets after deducting the value of all liabilites.")
    AccountMainType.create(name: "Income",      description: "The company's earnings and common examples.")
    AccountMainType.create(name: "Expense",     description: "The company's expenditures.")
  end

  def create_common_permissions
    Permission.create(subject_class: "LeaveApplication", action: "Create")
  end

  def create_employee_role
    permission = Permission.find_or_create_by(subject_class: "LeaveApplication", action: "Create")
    Role.create(name: "Employee", permissions: permission)
  end
end
