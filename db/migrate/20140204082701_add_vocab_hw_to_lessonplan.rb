class AddVocabHwToLessonplan < ActiveRecord::Migration
  def change
    add_column :lesson_plans, :vocab_hw, :text
  end
end
