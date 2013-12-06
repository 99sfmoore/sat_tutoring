class HwAnswer < ActiveRecord::Base
  belongs_to :student
  belongs_to :hw_question

  
end
