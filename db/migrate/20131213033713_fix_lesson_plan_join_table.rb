class FixLessonPlanJoinTable < ActiveRecord::Migration
  def change
    rename_column :lesson_plans_book_sections, :part_id, :book_section_id
  end
end
