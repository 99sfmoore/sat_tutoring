class LessonPlan < ActiveRecord::Base
  belongs_to :tutor
  belongs_to :group_meeting
  has_and_belongs_to_many :sections
  has_one :homework

  def name
    "Session \##{group_meeting.session_number} Lesson Plan"
  end
end