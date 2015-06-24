require 'spec_helper'

describe "Index todo items" do 
	# create a variable that can be used by test cases
	let!(:todo_list){TodoList.create(title: "Groceries", description: "Milk and eggs")}

	it "displays todo list title on the index page of todo items" do
		visit_todo_list(todo_list)
		within 'h1' do
			expect(page).to have_content(todo_list.title)
		end
	end

	it "displays items when the todo_list has items" do
		todo_list.todo_items.create(content: "Milk")
		todo_list.todo_items.create(content: "Eggs")

		visit_todo_list(todo_list)
		
		within "ul.todo_items" do
			expect(page).to have_content("Milk")
			expect(page).to have_content("Eggs")
		end
	end
end
