require "spec_helper"

describe "login" do
	it "displays the email address in the event of a failed login" do
		visit new_user_session_path
		fill_in "Email Address", with: "jingqi.hanzhong@gmail.com"
		fill_in "Password", with: "Incorrect"
		click_button "Login"
		expect(page).to have_content("Can not login")
		expect(page).to have_field("Email Address", with: "jingqi.hanzhong@gmail.com")
	end

	it "successfully logged in and redirects the user to todo_lists page" do 
		User.create(first_name: "Alvin",
					last_name: "Jing",
					email: "jingqi.hanzhong@gmail.com",
					password: "alvinjing",
					password_confirmation: "alvinjing"
					)
		visit new_user_session_path
		fill_in "Email Address", with: "jingqi.hanzhong@gmail.com"
		fill_in "Password", with: "alvinjing"
		click_button "Login"
		expect(page).to have_content("Todo Lists")
		expect(page).to have_content("Successfully logged in")
	end	
end

