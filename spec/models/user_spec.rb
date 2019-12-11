require 'rails_helper'

describe User, type: :model do
  let(:user) { build(:user) }

  it "has a valid factory of user" do
    expect(user).to be_valid
  end

  it "is invalid without name" do
    user.name = nil
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end

  it "is invalid if name too long" do
    user.name = 'a' * 21
    user.valid?
    expect(user.errors[:name]).to include("is too long (maximum is 20 characters)")
  end

  it "is invalid if name is not unique" do
    existed_user = build(:user, name: "username")
    existed_user.save

    user = build(:user, name: "username")
    user.valid?
    expect(user.errors[:name]).to include("has already been taken")
  end

  it "is invalid without email" do
    user.email = nil
    user.valid?
    expect(user.errors[:email]).to include("can't be blank")
  end

  it "is invalid if email in wrong format" do
    test_emails = %w(test test@gmail test@gmail,com)
    test_emails.each do |email|
      user.email = email
      user.valid?
      expect(user.errors[:email]).to include("is invalid")
    end
  end

  it "is invalid if duplicated email" do
    existed_user = build(:user, email: "test@gmail.com")
    existed_user.save

    user = build(:user, email: "Test@gmail.com")
    user.valid?
    expect(user.errors[:email]).to include("has already been taken")
  end

  it "is invalid if email is too long" do
    user.email = "a" * 256
    user.valid?
    expect(user.errors[:email]).to include("is too long (maximum is 255 characters)")
  end

  it "is invalid without password" do
    user.password = nil
    user.valid?
    expect(user.errors[:password]).to include("can't be blank")
  end

  it "is invalid if password is too short" do
    user.password = "pass"
    user.valid?
    expect(user.errors[:password]).to include("is too short (minimum is 8 characters)")
  end

  it "is invalid if password confirmation does not match" do
    user = User.new(password: "password", password_confirmation: "passwrod")
    user.valid?
    expect(user.errors[:password_confirmation]).to include("doesn't match Password")
  end
end
