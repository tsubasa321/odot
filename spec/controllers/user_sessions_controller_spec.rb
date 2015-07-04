require 'spec_helper'

describe UserSessionsController do

  describe "GET 'new'" do
    it "returns http success" do
      get 'new'
      response.should be_success
    end

    it "renders the new template" do
      get 'new'
      expect(response).to render_template('new')
    end
  end

  describe "POST 'create'" do

    context "with correct credentials" do

      let!(:user){User.create(first_name: "Alvin", last_name: "Jing", 
                           email: "jingqi.hanzhong@gmail.com",
                           password: "alvinjing",
                           password_confirmation: "alvinjing")
      }

      it "redirects to todo list path" do
        post :create, email: "jingqi.hanzhong@gmail.com", password: "alvinjing"
        expect(response).to be_redirect
        expect(response).to redirect_to(todo_lists_path)
      end

      it "finds the user" do  
        expect(User).to receive(:find_by).with({email: "jingqi.hanzhong@gmail.com"}).and_return(user)
        post :create, email: "jingqi.hanzhong@gmail.com", password: "alvinjing"
      end

      it "authenticates the user" do 
        User.stub(:find_by).and_return(user)
        expect(user).to receive(:authenticate)
        post :create, email: "jingqi.hanzhong@gmail.com", password: "alvinjing"
      end

      it "set the user id in the session" do
        post :create, email: "jingqi.hanzhong@gmail.com", password: "alvinjing"
        expect(session[:user_id]).to eq(user.id)
      end

    end

    shared_examples_for "denied login" do
      it "renders the new template" do 
        post :create, email: email, password: password
        expect(response).to render_template('new')
      end

      it "sets error message when user cannot login" do
        post :create, email: email, password: password
        expect(flash[:error]).to eq("Can not login")
      end
    end

    context "with blank credentials" do 
      let(:email){""}
      let(:password){""}
      it_behaves_like "denied login" 
    end

    context "with incorrect credentials" do
      let!(:user){User.create(first_name: "Alvin", last_name: "Jing", 
                           email: "jingqi.hanzhong@gmail.com",
                           password: "alvinjing",
                           password_confirmation: "alvinjing")
      }

      let(:email){ user.email }
      let(:password){ "Hello" }
      it_behaves_like "denied login" 
    end

    context "with email does not exist" do
      let(:email){"none@example.com"}
      let(:password){"Hello"}
      it_behaves_like "denied login" 
    end
  end

end
