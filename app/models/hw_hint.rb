class HwHint < ActiveRecord::Base
  belongs_to :question
  belongs_to :tutor

  def self.best(question, student, tutor, assignment)
    # top priority is anything already assigned
    # then answer specific & written by tutor
    # then answer specific
    # then general written by tutor
    # then any general hint
    hints = question.hw_hints
    if hints.empty?
      return nil
    else
      assigned = (assignment.hw_hints & hints)
      return assigned.first unless assigned.first.nil?
      answer_hints = hints.where("answer_choice = ?",question.student_answer(student))
      if answer_hints.count == 1
        return answer_hints.first 
      elsif answer_hints.count > 1
        tutor_answer_hints = answer_hints.where("tutor_id = ?",tutor.id)
        if !tutor_answer_hints.empty?
          return tutor_answer_hints.last 
        else
          return answer_hints.last
        end
      else
        general_hints = hints.where("answer_choice = ?","")
        if general_hints.empty?
          return nil
        else
          tutor_hints = general_hints.where("tutor_id = ?", tutor.id)
          if !tutor_hints.empty?
            return tutor_hints.last
          else
            return general_hints.last
          end
        end
      end
    end
  end

end
