require 'spec_helper'

describe "Edit todo items" do 

	# create a variable that can be used by test cases
	let!(:todo_list){TodoList.create(title: "Groceries", description: "Milk and eggs")}
	let!(:todo_item){todo_list.todo_items.create(content: "Milk")}

	it "deletes todo item successfully" do
		visit_todo_list(todo_list)

		within "#todo_item_#{todo_item.id}" do
			click_link "Delete"
		end

		expect(page).to have_content("Successfully deleted Todo Item")
	end
end