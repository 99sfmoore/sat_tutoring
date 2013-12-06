class FixAssignmentTypo < ActiveRecord::Migration
  def change
    rename_table :hw_assigments, :hw_assignments
  end
end
