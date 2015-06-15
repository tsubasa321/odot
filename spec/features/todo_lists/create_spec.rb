require 'spec_helper'

describe "Creating todo lists" do 

	def create_todo_list(options={})
		options[:title] ||= "Item"
		options[:description] ||= "This is an item"
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")
		
		fill_in "Title", with: options[:title]
		fill_in "Description", with: options[:description]
		click_button "Create Todo list"

	end
	it "redirects to the todo list index page on success" do

		create_todo_list title: "First item", description: "This is my first item in the todo list"

		expect(page).to have_content("First item")
	end

	it "displays an error when title is empty or length is less than 2" do

		create_todo_list title: "", description: "This is my first item in the todo list"
		
		expect(page).to have_content("error")

		fill_in "Title", with: "h"
		fill_in "Description", with: "This is my first item in the todo list"
		click_button "Create Todo list"
		expect(page).to have_content("error")
	end

	it "displays an error when description is empty" do

		create_todo_list title: "Item", description: ""
		
		expect(page).to have_content("error")

	end

end