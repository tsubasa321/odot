require 'spec_helper'

describe "Index todo items" do 
	# create a variable that can be used by test cases
	let!(:todo_list){TodoList.create(title: "Groceries", description: "Milk and eggs")}

	def visit_todo_list(list)
		visit "/todo_lists"

		within "#todo_list_#{list.id}" do
			click_link "List to do items"
		end
	end

	it "successfully creates a new todo item" do 
		todo_list.todo_items.create(content: "Milk")
		todo_list.todo_items.create(content: "Eggs")

		visit_todo_list(todo_list)

		click_link "New Todo Item"
		fill_in "Content", with: "Orange"
		click_button "Save"
		expect(page).to have_content("Successfully added new todo item")

		within "ul.todo_list" do
			expect(page).to have_content("Orange")
		end	
	end

end