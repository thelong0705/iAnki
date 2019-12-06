class AddRepitionToCards < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :repetitions, :integer, default: 0
    add_column :cards, :interval, :integer, default: 1
    add_column :cards, :easiness, :float, default: 2.5
  end
end
