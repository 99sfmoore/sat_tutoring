class RemoveTempTestIdColumn < ActiveRecord::Migration
  def change
    remove_column :questions, :temp_test_id
  end
end
