require "spec_helper"

describe "Sign up new user" do

	it "allows the user to sign up and create a new user in the database" do
		expect(User.count).to eq(0)

		visit "/"
		expect(page).to have_content("Sign Up")
		click_link "Sign Up"

		fill_in "First name", with: "Alvin"
		fill_in "Last name", with: "Jing"
		fill_in "Email", with: "jingqi.hanzhong@gmail.com"
		fill_in "Password", with: "123456"
		fill_in "Password confirmation", with: "123456"
		click_button "Sign Up"
		expect(User.count).to eq(1)
		expect(page).to have_content("User was successfully created")
	end	
end