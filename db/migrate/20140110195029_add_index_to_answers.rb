class AddIndexToAnswers < ActiveRecord::Migration
  def change
    add_column :answers, :second_try, :string
    add_index :answers, [:question_id, :student_id]
  end
end
