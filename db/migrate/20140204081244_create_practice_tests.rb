class CreatePracticeTests < ActiveRecord::Migration
  def change
    create_table :practice_tests do |t|
      t.belongs_to :site
      t.belongs_to :test
      t.datetime :date
      t.timestamps
    end
  end
end
