json.name "Accounts"
json.children @accounts do |account|
	json.name account.name
	if account.account_sub_types.present?
		json.children do
	    json.array!(account.account_sub_types) do |account_sub_type|
	      json.name account_sub_type.name
	      if account_sub_type.account_types.present?
		      json.children do
				    json.array!(account_sub_type.account_types) do |account_type|
				    	total_balance = 0
              if account_type.accounts.present?
                json.children do
                  json.array!(account_type.accounts) do |account|
                    json.name "["+account.name+", "+account.total_balance.to_s+"]"
                    total_balance += account.total_balance
                  end
                end
              else
                json.children false
              end
				      json.name "["+account_type.name+", "+total_balance.to_s+"]"
				    end
				  end
				else
					json.children false
				end
	    end
	  end
	 else
	 	json.children false
	 end
end
