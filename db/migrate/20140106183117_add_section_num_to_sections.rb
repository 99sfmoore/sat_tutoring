class AddSectionNumToSections < ActiveRecord::Migration
  def change
    add_column :sections, :section_num, :integer
  end
end
