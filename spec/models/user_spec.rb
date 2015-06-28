require 'spec_helper'

describe User do
	let!(:valid_attributes){
		{
			first_name: "Alvin",
			last_name: "Jing",
			email: "jingqi.hanzhong@gmail.com",
			password: "123456",
			password_confirmation: "123456"
		}
	}

	context "Validations" do
		let!(:user){User.new(valid_attributes)}

		before(:each) do
			User.create(valid_attributes)
		end
	  	
	  	it "requires the user to have a email" do
	  		expect(user).to validate_presence_of(:email)
	  	end

	  	it "requires unique email" do
	  		expect(user).to validate_uniqueness_of(:email)
	  	end

	  	it "violates uniqueness of email after downcase" do
	  		user = User.new(valid_attributes.merge(email: "JINGQI.HANZHONG@GMAIL.COM"))
	  		#user.downcase_email
	  		expect(user.save).to be_falsey #because of violaltion of uniqueness
	  		expect(user.email).to eq("jingqi.hanzhong@gmail.com")
	  	end

	  	it "downcase email before validation" do
	  		user = User.new(valid_attributes.merge(email: "JINGQI@hotmail.com"))
	  		#user.downcase_email
	  		expect(user.save).to be_truthy
	  		expect(user.email).to eq("jingqi@hotmail.com")
	  	end

	  	it "validates the format of email address" do
	  		user.email = "Alvin"
	  		expect(user).to_not be_valid
	  	end

  end
end
