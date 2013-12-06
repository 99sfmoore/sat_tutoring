class AddIndexToTutorsEmail < ActiveRecord::Migration
  def change
    add_index :tutors, :email, unique: true
  end
end
