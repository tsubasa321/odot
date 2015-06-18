require 'spec_helper'

describe "Index todo items" do 
	# create a variable that can be used by test cases
	let!(:todo_list){TodoList.create(title: "Groceries", description: "Apple and peach")}

	it "displays no item when the todo_list is empty" do
		visit "/todo_lists"

		within "#todo_list_#{todo_list.id}" do
			click_link "List to do items"
		end
		expect(page).to have_content("TodoItems#index")
	end
end
