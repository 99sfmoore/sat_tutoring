class RenameHwQuestionsToBookQuestions < ActiveRecord::Migration
  def change
    rename_table :hw_questions, :book_questions
  end
end
