class AddRememberTokenToTutors < ActiveRecord::Migration
  def change
    add_column :tutors, :remember_token, :string
    add_index :tutors, :remember_token
  end
end
