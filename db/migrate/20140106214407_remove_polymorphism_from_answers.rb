class RemovePolymorphismFromAnswers < ActiveRecord::Migration
  def change
    rename_column :answers, :questionlike_id, :question_id 
    remove_column :answers, :questionlike_type
  end
end
