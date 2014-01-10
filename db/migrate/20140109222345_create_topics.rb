class CreateTopics < ActiveRecord::Migration
  def change
    create_table :topics do |t|
      t.integer :number
      t.string :name
      t.integer :segment_id

      t.timestamps
    end
  end
end
