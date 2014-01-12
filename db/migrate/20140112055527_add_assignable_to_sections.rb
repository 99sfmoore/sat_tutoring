class AddAssignableToSections < ActiveRecord::Migration
  def change
    add_column :sections, :assignable, :boolean
  end
end
