class CreateDecks < ActiveRecord::Migration[6.0]
  def change
    create_table :decks do |t|
      t.string :name, null: false
      t.references :user, null: false, foreign_key: true
      t.timestamps
      t.index :name
    end
  end
end
