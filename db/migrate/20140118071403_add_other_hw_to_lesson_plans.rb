class AddOtherHwToLessonPlans < ActiveRecord::Migration
  def change
    add_column :lesson_plans, :other_hw, :text
  end
end
