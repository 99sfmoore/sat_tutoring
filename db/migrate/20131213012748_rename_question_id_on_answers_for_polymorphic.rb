class RenameQuestionIdOnAnswersForPolymorphic < ActiveRecord::Migration
  def change
    rename_column :answers, :question_id, :questionlike_id
    add_column :answers, :questionlike_type, :string 
  end
end
