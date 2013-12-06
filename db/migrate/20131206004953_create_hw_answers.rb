class CreateHwAnswers < ActiveRecord::Migration
  def change
    create_table :hw_answers do |t|
      t.integer :hw_question_id
      t.integer :student_id
      t.string :answer_choice

      t.timestamps
    end
  end
end
