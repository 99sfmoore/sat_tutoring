class CreateHwAssignments < ActiveRecord::Migration
  def change
    create_table :hw_assignments do |t|
      t.integer :category_id
      t.integer :start_page
      t.integer :end_page
      t.string :difficulty

      t.timestamps
    end
  end
end
