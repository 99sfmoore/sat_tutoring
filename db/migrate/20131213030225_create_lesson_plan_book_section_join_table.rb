class CreateLessonPlanBookSectionJoinTable < ActiveRecord::Migration
  def change
    create_table :lesson_plans_book_sections do |t|
      t.belongs_to :lesson_plan
      t.belongs_to :part
    end
  end
end
