class RenameAndDeleteQuestionsColumns < ActiveRecord::Migration
  def change
    remove_column :questions, :temp_section
    remove_column :questions, :segment
    rename_column :questions, :test_id, :temp_test_id
  end
end
