class CreateQuestions < ActiveRecord::Migration
  def change
    create_table :questions do |t|
      t.integer :test_id
      t.string :segment
      t.integer :section
      t.integer :question_num
      t.string :category
      t.string :difficulty
      t.string :correct_answer

      t.timestamps
    end
  end
end
