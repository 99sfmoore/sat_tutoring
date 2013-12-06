class AddAvatarToStudents < ActiveRecord::Migration
  def self.up  
    add_attachment :students, :avatar
  end

  def self.down
    remove_attachment :students, :avatar
  end
end
