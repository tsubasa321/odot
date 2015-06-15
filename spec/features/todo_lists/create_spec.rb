require 'spec_helper'

describe "Creating todo lists" do 
	it "redirects to the todo list index page on success" do
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")
		fill_in "Title", with: "First item"
		fill_in "Description", with: "This is my first item in the todo list"
		click_button "Create Todo list"

		expect(page).to have_content("First item")
	end

	it "displays an error when title is empty or length is less than 2" do
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")
		fill_in "Title", with: ""
		fill_in "Description", with: "This is my first item in the todo list"
		click_button "Create Todo list"
		expect(page).to have_content("error")

		fill_in "Title", with: "h"
		fill_in "Description", with: "This is my first item in the todo list"
		click_button "Create Todo list"
		expect(page).to have_content("error")
	end

	it "displays an error when description is empty" do
		visit "/todo_lists"
		click_link "New Todo list"
		expect(page).to have_content("New Todo List")
		fill_in "Title", with: "Item"
		fill_in "Description", with: ""
		click_button "Create Todo list"
		expect(page).to have_content("error")
	
	end

end