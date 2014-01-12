class AddTopicToSections < ActiveRecord::Migration
  def change
    add_column :sections, :topic_id, :integer
  end
end
