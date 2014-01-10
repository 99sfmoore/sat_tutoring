class AddAdminAndLeaderToTutors < ActiveRecord::Migration
  def change
    add_column :tutors, :admin, :boolean
    add_column :tutors, :leader, :boolean
  end
end
