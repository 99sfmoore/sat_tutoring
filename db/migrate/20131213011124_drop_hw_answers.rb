class DropHwAnswers < ActiveRecord::Migration
  def change
    drop_table :hw_answers
  end
end
