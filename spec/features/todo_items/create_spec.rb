require 'spec_helper'

describe "Index todo items" do 
	# create a variable that can be used by test cases
	let!(:todo_list){TodoList.create(title: "Groceries", description: "Milk and eggs")}

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

	it "displays error when the content is empty" do
		visit_todo_list(todo_list)

		click_link "New Todo Item"
		fill_in "Content", with: ""
		click_button "Save"

		within "div.flash" do
			expect(page).to have_content("Unable to add this new todo item")
		end

		expect(page).to have_content("Content can't be blank")
		
	end

end