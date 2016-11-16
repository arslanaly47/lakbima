module LeaveApplicationsHelper
  def class_decider(status)
    case status
    when "pending"
      "bg-info"
    when "approved"
      "bg-success"
    when "denied"
      "bg-danger"
    end
  end
end
