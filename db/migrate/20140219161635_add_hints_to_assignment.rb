class AddHintsToAssignment < ActiveRecord::Migration
  def change
    add_column :assignments, :send_hints, :boolean
  end
end
