class AddHighSchoolToStudents < ActiveRecord::Migration
  def change
    add_column :students, :high_school, :string
  end
end
