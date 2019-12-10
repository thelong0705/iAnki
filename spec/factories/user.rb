FactoryBot.define do
  factory :user do
    name { "test_user" }
    email { "test@gmail.com" }
    password { "password"}
    activated { "true" }
  end
end