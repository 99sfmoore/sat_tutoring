class CreateAssignments < ActiveRecord::Migration
  def change
    create_table :assignments do |t|
      t.integer :student_id
      t.integer :section_id
      t.boolean :complete
      t.timestamps
    end
  end
end
