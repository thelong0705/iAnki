class Card < ApplicationRecord
  searchkick
  belongs_to :deck, optional: true
  scope :not_remembered, -> { where(is_remembered:  false) }
end
