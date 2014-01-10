class SwitchOrderOfLessonPlanBookSection < ActiveRecord::Migration
  def change
    rename_table :lesson_plans_book_sections, :book_sections_lesson_plans
  end
end
