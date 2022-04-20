file '/hello.txt' do
	content 'Hello, World!'
	mode 0644 	# ensure the policy on mode file 
	owner 'root'	# ensure the poilicy on owner
	group 'root'	# ensure the policy on group
end
