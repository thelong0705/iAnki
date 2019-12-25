class Deck < ApplicationRecord
  belongs_to :user
  has_many :cards, dependent: :destroy
  accepts_nested_attributes_for :cards,
                                reject_if: :all_blank,
                                allow_destroy: true

  validates_presence_of :cards
  validates :name, presence: true

  #searchkick
  scope :is_public, -> { where(is_public: true) }
  scope :is_not_public, -> { where(is_public: false) }

  def self.csv_attributes
    %w(question answer)
  end


  def generate_csv
    CSV.generate(headers: true) do |csv|
      csv << Deck.csv_attributes
      cards.each do |card|
        csv << Deck.csv_attributes.map { |attr| card.send(attr) }
      end
    end
  end
end
