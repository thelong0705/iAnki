class CreateStudySessionCards < ActiveRecord::Migration[6.0]
  def change
    create_table :study_session_cards do |t|
      t.references :card, null: false, foreign_key: true
      t.references :study_session, null: false, foreign_key: true
      t.boolean :is_showed, default: false

      t.timestamps
    end
  end
end
