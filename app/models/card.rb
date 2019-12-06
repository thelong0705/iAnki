class Card < ApplicationRecord
  searchkick
  belongs_to :deck, optional: true
  scope :not_remembered, -> { where(is_remembered:  false) }
  scope :unlearn_card, -> { where(practice_day: nil).limit(5) }
  scope :review_today, -> { where(practice_day: Date.today)}
  scope :learn_today, -> { where(learn_at: Date.today)}

  def repeat_learning(quality)
    easiness = [1.3, self.easiness + 0.1 - (5 - quality) * (0.08 + (5 - quality) * 0.02)].max
    repetitions = quality < 3 ? 0 : self.repetitions + 1

    if repetitions <= 1
      interval = 1
    elsif repetitions == 2
      interval = 6
    else
      interval = (self.interval * easiness).round
    end

    practice_day = quality == 0 ? Date.today : Date.today + interval

    update({ repetitions: repetitions, easiness: easiness, interval: interval, practice_day: practice_day })
  end
end
