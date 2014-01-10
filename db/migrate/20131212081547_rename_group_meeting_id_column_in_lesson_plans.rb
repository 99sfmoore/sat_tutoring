class RenameGroupMeetingIdColumnInLessonPlans < ActiveRecord::Migration
  def change
    rename_column :lesson_plans, :group_meeting, :group_meeting_id
  end
end
