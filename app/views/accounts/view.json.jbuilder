json.name "Accounts"
json.children @accounts do |account|
  main_type_balance = 0
	json.name account.name
	if account.account_sub_types.present?
		json.children do
	    json.array!(account.account_sub_types) do |account_sub_type|
        sub_type_balance = 0
	      json.name account_sub_type.name
	      if account_sub_type.account_types.present?
		      json.children do
				    json.array!(account_sub_type.account_types) do |account_type|
				    	total_balance = 0
              if account_type.accounts.present?
                json.children do
                  json.array!(account_type.accounts) do |account|
                    json.name account.name
                    total_balance += account.total_balance(@start_date, @end_date)
                    json.amount account.total_balance(@start_date, @end_date).to_s
    								json.level "bold"
                  end
                end
              else
                json.children false
              end
				      json.name account_type.name
              json.amount total_balance.to_s
    					json.level "bold"
              sub_type_balance += total_balance
				    end
				  end
				else
					json.children false
				end
        json.amount sub_type_balance.to_s
        json.level "bold"
        main_type_balance += sub_type_balance
	    end
	  end
	else
	 	json.children false
	end
  json.amount main_type_balance.to_s
  json.level "bold"
end
