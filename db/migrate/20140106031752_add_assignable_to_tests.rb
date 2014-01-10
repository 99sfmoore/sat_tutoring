class AddAssignableToTests < ActiveRecord::Migration
  def change
    add_column :tests, :assignable, :boolean
  end
end
