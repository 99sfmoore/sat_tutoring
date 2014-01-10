class RenameBookSectionsLessonPlans < ActiveRecord::Migration
  def change
    rename_column :book_sections_lesson_plans, :book_section_id, :section_id
    rename_table :book_sections_lesson_plans, :lesson_plans_sections
  end
end
