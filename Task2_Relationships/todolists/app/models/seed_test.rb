User.destroy_all
TodoList.destroy_all
TodoItem.destroy_all
Profile.destroy_all

def digest_password(size)
	[*('A'..'Z'),*('0'..'9')].sample(size).join
end

def arbitrary_txt(size)
	[*('a'..'z')].sample(size).join
end

next_year = Date.today + 1.year

profiles = [
	{first_name: "Carly", last_name: "Fiorina", birth_year: 1954, gender: "female"},
	{first_name: "Donald", last_name: "Trump", birth_year: 1946, gender: "male"},
	{first_name: "Ben", last_name: "Carson", birth_year: 1951, gender: "male"},
	{first_name: "Hillary", last_name: "Clinton", birth_year: 1947, gender: "female"}
]

profiles.each do |profile|
	User.create! [
		{ username: profile[:last_name], password_digest: digest_password(10) }
	]
	user = User.find_by username: profile[:last_name]
	user.create_profile gender: profile[:gender], birth_year: profile[:birth_year], first_name: profile[:first_name], last_name: profile[:last_name]

	TodoList.create! [
		{ list_name: "list of #{profile[:last_name]}", list_due_date: next_year }
	]
	listi = TodoList.find_by list_name: "list of #{profile[:last_name]}"
	(1..5).each do |i|
		itemi = TodoItem.create! [
            {
              due_date: next_year, 
              title: "Title "+arbitrary_txt(5), 
              description: "Description "+arbitrary_txt(6)+" "+arbitrary_txt(5), 
              completed: false
            }
		]
		listi.todo_items << itemi
	end
	user.todo_lists << listi
end