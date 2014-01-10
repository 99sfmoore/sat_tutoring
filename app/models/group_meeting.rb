class GroupMeeting < ActiveRecord::Base
  belongs_to :site
  has_many :lesson_plans
  has_many :tutors, through: :lesson_plans

end
