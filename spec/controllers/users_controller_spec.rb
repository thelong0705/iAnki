require "rails_helper"

RSpec.describe UsersController, :type => :controller do
  describe "Get users#show" do
    it "should render the template" do
      user = create(:user)
      session[:user_id] = user.id
      get :show, params: { id: user.id }
      expect(response).to render_template("show")
    end
  end

  describe "Get users#edit" do
    it "should render the template" do
      user = create(:user)
      session[:user_id] = user.id
      get :edit, params: { id: user.id }
      expect(response).to render_template("edit")
    end

    it "should redirect to home url if not authenticated" do
      user_a = create(:user)
      user_b = create(:user, name: "user_b", email: "b@gmail.com")
      session[:user_id] = user_a.id
      get :edit, params: { id: user_b.id }
      expect(response).to redirect_to home_url
    end

    it "should redirect to root url if not logged in" do
      user = create(:user)
      get :edit, params: { id: user.id }
      expect(response).to redirect_to root_url
    end

  end

  describe "post users#update" do
    it "should redirect to the edit page" do
      user = create(:user)
      session[:user_id] = user.id
      post :update, params: { id: user.id, user: { name: 'test'}}

      expect(response).to redirect_to(edit_user_path(user))
    end
  end

  describe "post users#create" do
    it "should render the template" do
      post :create, params: { user: {
          name: "test",
          email: "test@gmail.com",
          password: "password",
          password_confirmation: "password"
      }}, format: :js

      expect(response.content_type).to eq "text/javascript; charset=utf-8"
    end
  end
end