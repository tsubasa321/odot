require 'spec_helper'

describe "Destroy todo lists" do 
	# create a variable that can be used by test cases
	let!(:todo_list){TodoList.create(title: "Groceries", description: "Apple and peach")}

	it "destroy the element succesfully" do
		visit "/todo_lists"

		# css element selector
		within "#todo_list_#{todo_list.id}" do
			click_link "Destroy"
		end

		expect(page).to_not have_content(todo_list.title) 
		expect(TodoList.count).to eq(0)
	end

end