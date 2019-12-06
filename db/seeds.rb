Card.delete_all
Deck.delete_all

10.times do
  User.create!(
      {
          name: Faker::Name.name,
          email: Faker::Internet.email,
          password: "password",
          activated: true
      }
  )
end

100.times do
  card_attributes = (1..10).reduce([]) do |array|
    array.push({ question: Faker::Lorem.word, answer: Faker::Lorem.word })
  end

  Deck.create!(
      {
          user: User.all.sample,
          name: Faker::Lorem.word,
          cards_attributes: card_attributes
      }
  )
end
