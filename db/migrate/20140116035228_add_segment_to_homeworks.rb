class AddSegmentToHomeworks < ActiveRecord::Migration
  def change
    add_column :homeworks, :segment_id, :integer
  end
end
