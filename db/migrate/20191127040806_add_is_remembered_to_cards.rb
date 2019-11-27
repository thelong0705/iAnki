class AddIsRememberedToCards < ActiveRecord::Migration[6.0]
  def change
    add_column :cards, :is_remembered, :boolean, default: false
  end
end
