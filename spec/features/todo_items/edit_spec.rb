require 'spec_helper'

describe "Edit todo items" do 

	# create a variable that can be used by test cases
	let!(:todo_list){TodoList.create(title: "Groceries", description: "Milk and eggs")}
	let!(:todo_item){todo_list.todo_items.create(content: "Milk")}


	def visit_todo_list(list)
		visit "/todo_lists"

		within "#todo_list_#{list.id}" do
			click_link "List to do items"
		end
	end

	it "successfully edited todo item" do
		visit_todo_list(todo_list)

		within "#todo_item_#{todo_item.id}" do
			click_link "Edit"
		end

		fill_in "Content", with: "Orange"
		click_button "Save"
		expect(page).to have_content("Successfully Edited new todo item")
		todo_item.reload
		expect(todo_item.content).to eq("Orange")
	end

end