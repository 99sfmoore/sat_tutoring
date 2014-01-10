class RenameBookSectionsHomeworks < ActiveRecord::Migration
  def change
    rename_column :book_sections_homeworks, :book_section_id, :section_id
    rename_table :book_sections_homeworks, :homeworks_sections
  end
end
