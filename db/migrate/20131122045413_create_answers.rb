class CreateAnswers < ActiveRecord::Migration
  def change
    create_table :answers do |t|
      t.integer :question_id
      t.integer :student_id
      t.string :answer_choice

      t.timestamps
    end
  end
end
