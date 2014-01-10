class DropBookQuestions < ActiveRecord::Migration
  def change
    drop_table :book_questions
  end
end
