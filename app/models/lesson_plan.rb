class LessonPlan < ActiveRecord::Base
  belongs_to :tutor
  belongs_to :group_meeting
  has_and_belongs_to_many :sections
  has_many :homeworks, dependent: :destroy

  def name
    "Session \##{group_meeting.session_number} - #{group_meeting.date.strftime("%B %d")}"
  end

  def number
    group_meeting.session_number
  end

  def date
    group_meeting.date
  end
end
