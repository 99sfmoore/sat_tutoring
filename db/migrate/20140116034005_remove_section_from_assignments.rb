class RemoveSectionFromAssignments < ActiveRecord::Migration
  def change
    remove_column :assignments, :section_id
  end
end
