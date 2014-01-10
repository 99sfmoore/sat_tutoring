class RenameHwAssignmentsToBookSections < ActiveRecord::Migration
  def change
    rename_table :hw_assignments, :book_sections
  end
end
