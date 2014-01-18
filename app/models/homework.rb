class Homework < ActiveRecord::Base
  belongs_to :lesson_plan
  has_one :tutor, through: :lesson_plan
  has_and_belongs_to_many :sections
  belongs_to :segment
  has_many :assignments

  VOCABULARY_OPTIONS = {"Story" => "Write a story using at least 20 vocabulary words.",
                        "Sentences" => "Write 6 sentences that each use 1 vocabulary word."}

  def name #may not need this
    "Homework \##{number} - #{segment.name}"
  end

  def number 
    self.lesson_plan.number
  end

  def email_subject
    "SAT #{segment.name} Homework \##{number}"
  end
end
