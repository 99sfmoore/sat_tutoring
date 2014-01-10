class AddSegmentIdToSections < ActiveRecord::Migration
  def change
    rename_column :sections, :segment, :segment_string
    add_column :sections, :segment_id, :integer
  end
end
