module LessonPlansHelper

  def last_lesson
    current_user.lesson_plans.select {|lp| lp.date < Date.current}.sort_by{|lp| lp.number}.last
  end

  def default_message(segment)
    "When you finish the #{segment.name} homework, please \"Reply All\" to send me your answers."
  end
end
