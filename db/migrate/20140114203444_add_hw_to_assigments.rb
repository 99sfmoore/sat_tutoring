class AddHwToAssigments < ActiveRecord::Migration
  def change
    add_column :assignments, :homework_id, :integer
  end
end
