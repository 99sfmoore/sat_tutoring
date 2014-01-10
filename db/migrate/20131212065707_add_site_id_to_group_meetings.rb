class AddSiteIdToGroupMeetings < ActiveRecord::Migration
  def change
    add_column :group_meetings, :site_id, :integer
  end
end
