class AddPostNotesToLessonPlans < ActiveRecord::Migration
  def change
    add_column :lesson_plans, :post_notes, :text
  end
end
