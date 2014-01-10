class RenameBookSectionToSection < ActiveRecord::Migration
  def change
    rename_table :book_sections, :sections
  end
end
