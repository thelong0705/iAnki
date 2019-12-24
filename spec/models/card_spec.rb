require 'rails_helper'

describe Card, type: :model do
  let(:card) { build(:card) }

  it "has a valid factory of card" do
    expect(card).to be_valid
  end

  it "repeat learning" do
    card.save
    card.repeat_learning(0)
    expect(card.practice_day).to eq(Date.today)
  end

  it "get interval right" do
    card.save
    expect(card.get_interval(0)).to eq(0)
  end

end