class AddSecondTryToAssignments < ActiveRecord::Migration
  def change
    add_column :assignments, :second_try, :string
  end
end
