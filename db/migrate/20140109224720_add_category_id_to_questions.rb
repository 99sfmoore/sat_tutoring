class AddCategoryIdToQuestions < ActiveRecord::Migration
  def change
    rename_column :questions, :category, :category_string
    add_column :questions, :category_id, :integer
  end
end
