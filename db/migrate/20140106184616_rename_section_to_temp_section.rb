class RenameSectionToTempSection < ActiveRecord::Migration
  def change
    rename_column :questions, :section, :temp_section
  end
end
