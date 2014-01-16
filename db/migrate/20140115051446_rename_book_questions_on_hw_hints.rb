class RenameBookQuestionsOnHwHints < ActiveRecord::Migration
  def change
    rename_column :hw_hints, :book_question_id, :question_id
  end
end
