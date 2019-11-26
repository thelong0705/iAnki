class Deck < ApplicationRecord
  belongs_to :user
  has_many :cards
  accepts_nested_attributes_for :cards,
                                reject_if: lambda {|attributes| attributes['question'].blank?}
end
