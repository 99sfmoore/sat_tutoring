class HwHint < ActiveRecord::Base
  belongs_to :question
  # has_one :created_by, class_name :tutor
end
