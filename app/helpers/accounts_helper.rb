module AccountsHelper
  def class_for_account(account_main_type_id)
    case account_main_type_id
      when 1 
        "asset-account"
      when 2
        "liability-account"
      when 3
        "equity-account"
      when 4
        "income-account"
      when 5
        "expense-account"
    end
  end
end
