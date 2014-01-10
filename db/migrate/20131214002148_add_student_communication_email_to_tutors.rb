class AddStudentCommunicationEmailToTutors < ActiveRecord::Migration
  def change
    add_column :tutors, :email_for_students, :string
  end
end
