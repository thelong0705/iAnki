class StudySessionCard < ApplicationRecord
  belongs_to :card
  belongs_to :study_session
  scope :not_have_showed, -> { where(is_showed:  false) }
  scope :have_showed, -> { where(is_showed:  true) }
end
