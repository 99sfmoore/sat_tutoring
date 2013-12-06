class CreateScores < ActiveRecord::Migration
  def change
    create_table :scores do |t|
      t.integer :student_id
      t.integer :test_id
      t.integer :math
      t.integer :reading
      t.integer :writing

      t.timestamps
    end
  end
end
