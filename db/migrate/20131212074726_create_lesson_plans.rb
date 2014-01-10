class CreateLessonPlans < ActiveRecord::Migration
  def change
    create_table :lesson_plans do |t|
      t.integer :tutor_id
      t.integer :group_meeting

      t.timestamps
    end
  end
end
