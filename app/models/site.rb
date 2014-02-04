
class Site < ActiveRecord::Base
  has_many :students
  has_many :tutors
  has_many :group_meetings
  has_many :practice_tests
  belongs_to :team_leader, class_name: 'Tutor', foreign_key: :team_leader_id

  def add_students_from_file(filename)
    CSV.foreach(filename.path, headers: true) do |row|
      self.students.build(row.to_hash)
    end
  end

  def add_tutors_from_file(filename)
    CSV.foreach(filename.path, headers: true) do |row|
      tutor = self.tutors.build(row.to_hash) 
      # change this to a site-specific default
      tutor.update_attributes(password: "khccsatprep", password_confirmation: "khccsatprep") 
    end
  end

  def load_answers(test, filepath)
    CSV.foreach(filepath, headers: true) do |row|
      answer_hash = row.to_hash
      answer_hash["question_num"] = answer_hash["question_num"].to_i
      answer_hash["section"] = answer_hash["section"].to_i
      question = Question.where("test_id = ? AND section = ? AND question_num = ?", test, answer_hash["section"], answer_hash["question_num"]).first
      self.students.each do |student|
        if answer_hash[student.full_name]
          student.answers.build(questionlike_id: question.id, questionlike_type: question.class.to_s, answer_choice: answer_hash[student.full_name])
        end
      end
    end
    self.students.each do |student|
      student.save
    end
  end

end
