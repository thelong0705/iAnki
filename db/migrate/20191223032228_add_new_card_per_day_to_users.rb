class AddNewCardPerDayToUsers < ActiveRecord::Migration[6.0]
  def change
    add_column :users, :new_cards_per_day, :integer, default: 5
    add_column :users, :old_cards_per_day, :integer, default: 5
  end
end
