class StudentMailer < ActionMailer::Base

  def hint_email(student, sender, hw, message, hints)
    @student = student
    @sender = sender
    @hw = hw
    @message = message
    @hints = hints
    mail(to: "#{@student.full_name} <#{@student.email}>",
          from: "#{@sender.full_name} <#{@sender.email_for_students}>",
          cc: [@student.site.leader_email, @student.site.cp_email, (@student.tutor.email_for_students unless @student.tutor == @sender)],
          bcc: @sender.email_for_students,
          subject: @hw.email_subject)
  end

  def hw_email(student, sender, hw, message)
    @student = student
    @sender = sender
    @hw = hw
    @message = message
    mail(to: "#{@student.full_name} <#{@student.email}>",
          from: "#{@sender.full_name} <#{@sender.email_for_students}>",
          cc: [@student.site.leader_email, @student.site.cp_email, (@student.tutor.email_for_students unless @student.tutor == @sender)],
          bcc: @sender.email_for_students,
          subject: @hw.email_subject)
  end
end
