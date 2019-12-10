require 'rails_helper'

describe "user signup", type: :system do
  let!(:user) { FactoryBot.build(:user) }

  before do
    visit root_path
    click_button 'buttonSignUpModal'
    fill_in 'Name', with: user.name
    fill_in 'Email', with: user.email
    fill_in 'Password', with: user.password
    fill_in 'Password confirmation', with: user.password
    click_button "buttonSignUp"
  end

  context "user enter information correctly" do
    it "user signed up successfully" do
      expect(page).to have_content I18n.t(:check_your_email)
    end
  end

end