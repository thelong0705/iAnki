class AddUniqueIdAndRemoveColumnToStudySession < ActiveRecord::Migration[6.0]
  def change
    add_column :study_sessions, :unique_id, :integer
    remove_column :study_sessions, :user_id
  end
end
