class RenameForeignKeyOnBookQuestions < ActiveRecord::Migration
  def change
    rename_column :book_questions, :hw_assignment_id, :book_section_id
  end
end
