class EditCategoryTable < ActiveRecord::Migration
  def change
    rename_column :categories, :topic, :topic_id
    remove_column :categories, :segment
  end
end
