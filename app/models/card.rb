class Card < ApplicationRecord
  searchkick

  belongs_to :deck, optional: true
  scope :not_remembered, -> { where(is_remembered:  false) }
  scope :unlearn_card, -> { where(practice_day: nil).limit(5) }
  scope :review_today, -> { where(practice_day: Date.today).limit(5)}
  scope :learn_today, -> { where(learn_at: Date.today)}

  def repeat_learning(answer)
    update repeat_by_fibonacci answer
  end

  def get_interval(answer)
    repeat_by_fibonacci(answer)[:interval]
  end

  private

  def repeat_by_fibonacci(answer)
    repetitions = answer == 0 ? 0 : self.repetitions + 1
    interval = fibonacci(repetitions)
    practice_day = Date.today + interval

   { repetitions: repetitions, interval: interval, practice_day: practice_day }
  end

  def fibonacci(n)
    n <= 1 ? n + 1 :  fibonacci( n - 1 ) + fibonacci( n - 2 )
  end
end
