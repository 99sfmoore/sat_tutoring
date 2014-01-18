class AddIndexToAssignmentsJoinTable < ActiveRecord::Migration
  def change
    add_index :assignments_hw_hints, [:assignment_id, :hw_hint_id], unique: true
  end
end
