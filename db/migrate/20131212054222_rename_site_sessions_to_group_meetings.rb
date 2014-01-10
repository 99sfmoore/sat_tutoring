class RenameSiteSessionsToGroupMeetings < ActiveRecord::Migration
  def change
    rename_table :site_sessions, :group_meetings
  end
end
