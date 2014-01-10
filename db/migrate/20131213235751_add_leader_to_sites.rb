class AddLeaderToSites < ActiveRecord::Migration
  def change
    add_column :sites, :team_leader_id, :integer
  end
end
