class StudySession < ApplicationRecord
  belongs_to :user
  belongs_to :deck
  has_many :study_session_cards, dependent: :destroy
end
