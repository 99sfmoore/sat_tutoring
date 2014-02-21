class StudentMailer < ActionMailer::Base

  def hint_email(student, sender, hw, message, hints)
    @student = student
    @sender = sender
    @hw = hw
    @message = message
    @hints = hints
    mail(to: "#{@student.full_name} <#{@student.email}>",
          from: "#{@sender.full_name} <#{@sender.email_for_students}>",
          cc: [@student.site.leader_email, @student.site.cp_email, (@student.tutor.email_for_students unless @student.tutor == @sender),
            ("insafjaleel@gmail.com" if @student.tutor == Tutor.find_by(last_name:"Lam") && @sender.last_name != "Jaleel")],
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
          cc: [@student.site.leader_email, @student.site.cp_email, (@student.tutor.email_for_students unless @student.tutor == @sender),
             ("insafjaleel@gmail.com" if @student.tutor == Tutor.find_by(last_name:"Lam") && @sender.last_name != "Jaleel")],
          bcc: @sender.email_for_students,
          subject: @hw.email_subject)
  end

  def vocab_email(student,sender, number, message)
    @student = student
    @sender = sender
    @message = message
    mail(to: "#{@student.full_name} <#{@student.email}>",
          from: "#{@sender.full_name} <#{@sender.email_for_students}>",
          cc: [@student.site.leader_email, @student.site.cp_email, (@student.tutor.email_for_students unless @student.tutor == @sender),
            ("insafjaleel@gmail.com" if @student.tutor == Tutor.find_by(last_name:"Lam") && @sender.last_name != "Jaleel")],
          bcc: @sender.email_for_students,
          subject: "SAT Vocabulary Homework \##{number}")
  end

  def group_email(site, subject, message)
    @message = message
    mail(to: "#{site.cp_contact_name} <#{site.cp_email}>",
          from: "#{site.team_leader.full_name} <#{site.leader_email}>",
          bcc: site.students.map {|s| s.email},
          subject: subject)
  end
end
