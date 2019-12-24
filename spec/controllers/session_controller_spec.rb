require "rails_helper"

RSpec.describe SessionsController, :type => :controller do
  describe "Get sessions#create" do
    it "should render the template" do
      user = create(:user)
      post :create, params: {session: {email: user.email, password: user.password}}
      expect(response).to redirect_to home_url
    end

    it "should return js if wrong password" do
      user = create(:user)
      post :create, params: {
          session: {email: user.email, password: 'pass'},
          format: :js
      }
      expect(response.content_type).to eq "text/javascript; charset=utf-8"
    end

    it "should return js if didnt found user" do
      user = build(:user)
      post :create, params: {
          session: {email: user.email, password: 'pass'},
          format: :js
      }
      expect(response.content_type).to eq "text/javascript; charset=utf-8"
    end

    it "should return js if user is not activated" do
      user = create(:user, activated: false)
      post :create, params: {
          session: {email: user.email, password: user.password},
          format: :js
      }
      expect(response.content_type).to eq "text/javascript; charset=utf-8"
    end
  end

  describe "Get sessions#destroy" do
    it "should redirect to root url" do
      user = create(:user)
      session[:user_id] = user.id
      get :destroy, method: :delete
      expect(response).to redirect_to root_url
    end
  end
end