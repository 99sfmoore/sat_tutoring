class AddEmailAndTutorToStudents < ActiveRecord::Migration
  def change
    add_column :students, :email, :string
    add_column :students, :tutor_id, :integer
  end
end
