module LessonPlansHelper

  def last_lesson
    current_user.lesson_plans.select {|lp| lp.date < Date.current}.sort_by{|lp| lp.number}.last
  end

  def default_message(subject, assignment, session_date)
    first = "When you finish the #{subject} homework, please \"Reply All\" to send me your answers.  As a reminder, the assignment is:"
    if subject == "Vocabulary"
      second = assignment+"\n"
      third = "This is due by #{(session_date + 6.days).strftime("%A, %B %e")}."
    else
      second = ""
      assignment.sections.each do |s|
        second = second + "#{s.name_for_students}" + "\n"
      end
      if assignment.second_try?
        third = "Your first try is due by #{(session_date + 5.days).strftime("%A, %B %e")}. Then send me new answers for the questions you missed by #{(session_date + 6.days).strftime("%A, %B %e")}."
      else
        third = "This is due by #{(session_date + 6.days).strftime("%A, %B %e")}."
      end
    end
    ending = "See you next week!"
    first + "\n\n" + second + "\n" + third + "\n\n" + ending
  end
end
