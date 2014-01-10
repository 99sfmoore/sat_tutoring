class StudentMailer < ActionMailer::Base
  default from: "satsarah2400@gmail.com"

  def test_email(student)
    @student = Student.find(student)
    mail(to: @student.email,subject: "Testing")
  end

  def hint_email(student, section, message, hints)
    @student = Student.find(student)
    @section = section
    @message = message
    @hints = hints
    mail(to: @student.email,
          from: @student.tutor.email_for_students,
          cc: [@student.site.leader_email, @student.site.cp_email],
          bcc: @student.tutor.email_for_students,
          subject: "HW Hints")
  end
end
