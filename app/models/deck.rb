class Deck < ApplicationRecord
  belongs_to :user
  has_many :cards
  accepts_nested_attributes_for :cards,
                                reject_if: :all_blank,
                                allow_destroy: true

  def self.csv_attributes
    %w(question answer)
  end

  def self.import_csv(file)
    cards_attributes = []
    CSV.foreach(file, headers: true) do |row|
      cards_attributes << row.to_hash.slice(*csv_attributes)
    end
    create({name: "draft", cards_attributes: cards_attributes})
  end

  def generate_csv
    CSV.generate(headers: true) do |csv|
      csv << Deck.csv_attributes
      cards.each do |card|
        csv << Deck.csv_attributes.map { |attr| card.send(attr) }
      end
      p csv
    end
  end
end
