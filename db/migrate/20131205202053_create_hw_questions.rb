class CreateHwQuestions < ActiveRecord::Migration
  def change
    create_table :hw_questions do |t|
      t.integer :hw_assignment_id
      t.integer :question_num
      t.string :correct_answer

      t.timestamps
    end
  end
end
