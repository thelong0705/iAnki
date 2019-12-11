require 'rails_helper'

describe "user signup", type: :system do
  let(:right_user) { FactoryBot.build(:user, password: "password", password_confirmation: "password") }
  let(:wrong_user) { FactoryBot.build(:user, password: "password", password_confirmation: "wrong_password") }

  before do
    visit root_path
    click_button 'buttonSignUpModal'
    fill_in 'Name', with: sign_up_user.name
    fill_in 'Email', with: sign_up_user.email
    fill_in 'Password', with: sign_up_user.password
    fill_in 'Password confirmation', with: sign_up_user.password_confirmation
    click_button "buttonSignUp"
  end

  context "user enter information correctly" do
    let(:sign_up_user) { right_user }
    it "user signed up successfully" do
      expect(page).to have_content I18n.t(:check_your_email)
    end
  end

  context "user enter information incorrectly" do
    let!(:sign_up_user) { wrong_user }

    before do
      sign_up_user.save
    end

    it "show errors" do
      expect(page).to have_content sign_up_user.errors.full_messages.first
    end
  end
end