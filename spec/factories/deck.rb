FactoryBot.define do
  factory :deck do
    name { 'test deck' }
    cards_attributes { [{question: "q", answer: "a"}] }
    user
  end
end