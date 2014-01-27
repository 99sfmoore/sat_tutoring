class AddDiffNumToQuestions < ActiveRecord::Migration
  def change
    add_column :questions, :difficulty_num, :integer
  end
end
