class Assignment < ActiveRecord::Base
  belongs_to :student
  belongs_to :homework
  has_and_belongs_to_many :hw_hints
end
