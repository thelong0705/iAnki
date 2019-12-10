require 'rails_helper'

describe "user function", type: :system do
  describe "user login" do
    let(:user_a) { FactoryBot.create(:user, email: "a@gmail.com") }
    let(:user_b) { FactoryBot.create(:user, email: "b@gmail.com", password: "wrong_password") }

    before do
      visit root_path
      click_button 'buttonLoginModal'
      fill_in 'Email', with: login_user.email
      fill_in 'Password', with: "password"
      click_button "buttonLogin"
    end

    context "user enter information correctly" do
      let(:login_user) { user_a }

      it "user logged successfully" do
        expect(page).to have_content "Welcome"
      end
    end

    context "user enter information incorrectly" do
      let(:login_user) { user_b }

      it "user logged successfully" do
        expect(page).to have_content "Invalid Password"
      end
    end
  end
end