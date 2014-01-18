class CreateAssignmentsHintsTable < ActiveRecord::Migration
  def change
    create_table :assignments_hw_hints do |t|
      t.belongs_to :assignment
      t.belongs_to :hw_hint
    end
  end
end
