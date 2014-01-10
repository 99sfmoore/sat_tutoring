class Homework < ActiveRecord::Base
  belongs_to :lesson_plan
  has_and_belongs_to_many :sections

  VOCABULARY_OPTIONS = {"Story" => "Write a story using at least 20 vocabulary words.",
                        "Sentences" => "Write 6 sentences that each use 1 vocabulary word."}

  def name
    "HOMEWORK - Session \##{number}"
  end

  def number
    self.lesson_plan.group_meeting.session_number
  end
end
