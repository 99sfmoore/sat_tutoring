class ChangeNamesInBookSectionHwJoin < ActiveRecord::Migration
  def change
    rename_column :book_sections_homeworks, :book_section_id_id, :book_section_id
    rename_column :book_sections_homeworks, :homework_id_id, :homework_id

  end
end
