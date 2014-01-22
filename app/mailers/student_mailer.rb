class StudentMailer < ActionMailer::Base
  default from: "satsarah2400@gmail.com"

  def test_email(student)
    @student = Student.find(student)
    mail(to: @student.email,subject: "Testing")
  end

  def hint_email(student, hw, message, hints)
    @student = student
    @hw = hw
    @message = message
    @hints = hints
    mail(to: @student.email,
          from: current_user.email_for_students,
          cc: [@student.site.leader_email, @student.site.cp_email, (@student.tutor.email_for_students unless @student.tutor == current_user)],
          bcc: current_user.email_for_students,
          subject: @hw.email_subject)
  end
end
