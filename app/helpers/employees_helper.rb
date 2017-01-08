module EmployeesHelper
  def get_class_for_employee(employee)
    return "current-employees" if employee.current?
    return "future-employees"  if employee.future?
    return "past-employees"    if employee.terminated?
  end
end
