class Deck < ApplicationRecord

  belongs_to :user
  has_many :cards
  accepts_nested_attributes_for :cards,
                                reject_if: :all_blank,
                                allow_destroy: true
  searchkick


  def self.csv_attributes
    %w(question answer)
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
