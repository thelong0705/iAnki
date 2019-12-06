class AddLearnAtToCards < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :learn_at, :date
  end
end
