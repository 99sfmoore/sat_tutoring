class CreateRawScores < ActiveRecord::Migration
  def change
    create_table :raw_scores do |t|
      t.belongs_to :test 
      t.belongs_to :student
      t.float :math
      t.float :reading
      t.float :writing
      t.timestamps
    end
  end
end
