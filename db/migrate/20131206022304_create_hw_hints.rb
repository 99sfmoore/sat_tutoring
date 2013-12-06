class CreateHwHints < ActiveRecord::Migration
  def change
    create_table :hw_hints do |t|
      t.integer :created_by
      t.integer :hw_question_id
      t.string :answer_choice
      t.text :hint

      t.timestamps
    end
  end
end
