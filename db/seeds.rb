20.times do
  User.create!(
      {
          name: Faker::Name.name[0..19],
          email: Faker::Internet.email,
          password: "password",
          activated: true
      }
  )
end

200.times do
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
