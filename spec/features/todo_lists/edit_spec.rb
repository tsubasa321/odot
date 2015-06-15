require 'spec_helper'

describe "Edit todo lists" do 
	# create a variable that can be used by test cases
	let!(:todo_list){TodoList.create(title: "Groceries", description: "Apple and peach")}

	def edit_todo_list(options={})
		options[:title] ||= "Default title"
		options[:description] ||= "Default description"

		todo_list = options[:todo_list]
		
		visit "/todo_lists"

		# css element selector
		within "#todo_list_#{todo_list.id}" do
			click_link "Edit"
		end

		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Update Todo list"
		
	end

	it "Edit succesfully when filled with correct information" do
		#todo_list = TodoList.create(title: "Groceries", description: "Apple and peach")
		
		edit_todo_list title: "New Item", 
						description: "New Description", 
						todo_list: todo_list

		todo_list.reload
		expect(page).to have_content("Todo list was successfully updated")
		expect(todo_list.title).to eq("New Item")
		expect(todo_list.description).to eq("New Description")
	end

	it "Displays error when title is not present" do
		edit_todo_list title: "", 
						description: "New Description", 
						todo_list: todo_list
		expect(page).to have_content"error"
	end

	it "Displays error when title is less than 2 characters" do
		edit_todo_list title: "a", 
						description: "New Description", 
						todo_list: todo_list
		expect(page).to have_content"error"
	end

	it "Displays error when description is not present" do
		edit_todo_list title: "New Item", 
						description: "", 
						todo_list: todo_list
		expect(page).to have_content"error"
	end
end