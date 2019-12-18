class CreateStudySessions < ActiveRecord::Migration[6.0]
  def change
    create_table :study_sessions do |t|
      t.references :user, null: false, foreign_key: true
      t.references :deck, null: false, foreign_key: true

      t.timestamps
    end
  end
end
