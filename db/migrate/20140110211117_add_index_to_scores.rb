class AddIndexToScores < ActiveRecord::Migration
  def change
    add_index :scores, [:test_id, :student_id]
  end
end
