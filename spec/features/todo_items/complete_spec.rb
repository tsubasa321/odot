require 'spec_helper'

describe "Complete todo items" do 

	# create a variable that can be used by test cases
	let!(:todo_list){TodoList.create(title: "Groceries", description: "Milk and eggs")}
	let!(:todo_item){todo_list.todo_items.create(content: "Milk")}

	it "successfully marked complete to an todo item" do
		expect(todo_item.completed_at).to be_nil
		visit_todo_list(todo_list)

		within dom_id_for(todo_item) do
			click_link "Mark Complete"
		end

		todo_item.reload
		expect(todo_item.completed_at).to_not be_nil
	end

end