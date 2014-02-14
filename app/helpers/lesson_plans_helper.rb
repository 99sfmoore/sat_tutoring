module LessonPlansHelper

  def last_lesson
    current_user.lesson_plans.select {|lp| lp.date < Date.current}.sort_by{|lp| lp.number}.last
  end

  def default_message(subject)
    "When you finish the #{subject} homework, please \"Reply All\" to send me your answers.\n\nSee you next week!"
  end
end
