class RenameQuestionIdOnHwHintsToBookQuestionId < ActiveRecord::Migration
  def change
    rename_column :hw_hints, :hw_question_id, :book_question_id
  end
end
