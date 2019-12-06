class AddPracticeDayToCards < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :practice_day, :date
  end
end
