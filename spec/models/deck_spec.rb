require 'rails_helper'

  describe Deck, type: :model do
    let(:deck) { build(:deck) }

    it "has a valid factory of deck" do
      expect(deck).to be_valid
    end

    it "is invalid without name" do
      deck.name = nil
      deck.valid?
      expect(deck.errors[:name]).to include("can't be blank")
    end

    it "has valid csv attributes" do
      expect(Deck.csv_attributes).to eq(%w(question answer))
    end

    it "generates_csv" do
      expect(deck.generate_csv).to eq("question,answer\nq,a\n")
    end
  end