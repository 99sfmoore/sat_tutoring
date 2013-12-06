class HwAssignment < ActiveRecord::Base
  belongs_to :category
  has_many :hw_questions
end
