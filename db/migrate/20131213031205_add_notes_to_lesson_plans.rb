class AddNotesToLessonPlans < ActiveRecord::Migration
  def change
    add_column :lesson_plans, :notes, :text
  end
end
