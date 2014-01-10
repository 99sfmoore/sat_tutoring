class AddTestIdAndSegmentToSections < ActiveRecord::Migration
  def change
    add_column :sections, :test_id, :integer
    add_column :sections, :segment, :string
  end
end
