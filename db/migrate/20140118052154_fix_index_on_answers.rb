class FixIndexOnAnswers < ActiveRecord::Migration
  def change
    remove_index :answers, [:question_id, :student_id]
    add_index :answers, [:question_id, :student_id], unique: true
  end
end
