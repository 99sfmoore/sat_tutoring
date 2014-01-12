class RemoveDifficultyAndSegmentStringFromSections < ActiveRecord::Migration
  def change
    remove_column :sections, :difficulty
    remove_column :sections, :segment_string
  end
end
