class RemoveCategoryFromSections < ActiveRecord::Migration
  def change
    remove_column :sections, :category_id
  end
end
