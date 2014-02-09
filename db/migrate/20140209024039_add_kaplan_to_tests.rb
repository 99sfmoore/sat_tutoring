class AddKaplanToTests < ActiveRecord::Migration
  def change
    add_column :tests, :kaplan, :boolean
  end
end
