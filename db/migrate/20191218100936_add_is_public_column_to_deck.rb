class AddIsPublicColumnToDeck < ActiveRecord::Migration[6.0]
  def change
    add_column :decks, :is_public, :boolean, default: true
  end
end
