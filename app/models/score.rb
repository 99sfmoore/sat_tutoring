class Score < ActiveRecord::Base
  belongs_to :student
  belongs_to :test

  def total
    math + reading + writing
  end
end
