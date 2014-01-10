class AddTlEmailAndCpNicknameToSites < ActiveRecord::Migration
  def change
    add_column :sites, :leader_email, :string
    add_column :sites, :cp_nickname, :string
  end
end
