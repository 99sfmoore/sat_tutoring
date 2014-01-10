class AddNumOfQuestionsToHwAssignments < ActiveRecord::Migration
  def change
    add_column :hw_assignments, :num_of_questions, :integer
  end
end
