class SeedNewTenant
  def call
    create_header_accounts
    create_employee_role
    create_departments
    create_job_titles
  end

  private
  def create_header_accounts
    AccountMainType.find_or_create_by(name: "Assets",      description: "Something owned or controlled by an entity")
    AccountMainType.find_or_create_by(name: "Liabilities", description: "Economic obligations of an entity.")
    AccountMainType.find_or_create_by(name: "Equity",      description: "The value of assets after deducting the value of all liabilites.")
    AccountMainType.find_or_create_by(name: "Income",      description: "The company's earnings and common examples.")
    AccountMainType.find_or_create_by(name: "Expense",     description: "The company's expenditures.")
  end

  def create_employee_role
    permissions = []
    permissions << Permission.find_or_create_by(subject_class: "LeaveApplication", action: "Create")
    Role.create(name: "Employee", permissions: permissions)
  end

  def create_departments
    @production_department = Department.create(name: "Production", description: "This department is responsible for producing stuff, and other things, and it's main and important one.")
    @sales_department      = Department.create(name: "Sales", description: "A department related to sales, and purchases.")
    @management_department = Department.create(name: "Management", description: "This department is responsible for managing all kind of things.")
  end

  def create_job_titles
    create_job_titles_for_production
    create_job_titles_for_sales
    create_job_titles_for_management
  end

  def create_job_titles_for_production
    JobTitle.find_or_create_by(name: "Chef", description: "Quality Controls and planning the Recipes and Production.", department: @production_department)
    JobTitle.find_or_create_by(name: "Store Keeper", description: "Manager of the store and record keeper.", department: @production_department)
  end

  def create_job_titles_for_sales
    JobTitle.find_or_create_by(name: "Finance Manager", description: "This person will be responsible for managing all kind of financial matters.", department: @sales_department)
    JobTitle.find_or_create_by(name: "Accountant", description: "Financial accounting.", department: @sales_department)
    JobTitle.find_or_create_by(name: "Waiter", description: "Serves food.", department: @sales_department)
    JobTitle.find_or_create_by(name: "Managing Director", description: "One the directors who manage the business directly.", department: @sales_department)
    JobTitle.find_or_create_by(name: "General Manager", description: "Manages all the branches and reporting to Managing Director.", department: @sales_department)
    JobTitle.find_or_create_by(name: "Assistant Cook", description: "", department: @sales_department)
    JobTitle.find_or_create_by(name: "Cook", description: "To assist the chef.", department: @sales_department)
  end

  def create_job_titles_for_management
    JobTitle.find_or_create_by(name: "Mandoob", description: "PRO", department: @management_department)
  end
end
