require 'rails_helper'

describe "user login", type: :system do
  let(:user_a) { FactoryBot.create(:user, email: "a@gmail.com") }
  let(:user_b) { FactoryBot.create(:user, email: "b@gmail.com", password: "wrong_password") }
  let(:user_c) { FactoryBot.create(:user, activated: false) }

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
      expect(page).to have_content I18n.t(:welcome)
    end
  end

  context "user enter information incorrectly" do
    let(:login_user) { user_b }

    it "show invalid password" do
      expect(page).to have_content I18n.t(:invalid_password)
    end
  end

  context "user enter unactivated email" do
    let(:login_user) { user_c }

    it "show unactivated email" do
      expect(page).to have_content I18n.t(:unactivated_email)
    end
  end
end