class CreateSiteSessions < ActiveRecord::Migration
  def change
    create_table :site_sessions do |t|
      t.integer :session_number
      t.datetime :date

      t.timestamps
    end
  end
end
