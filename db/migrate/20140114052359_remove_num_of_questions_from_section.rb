class RemoveNumOfQuestionsFromSection < ActiveRecord::Migration
  def change
    remove_column :sections, :num_of_questions
  end
end
