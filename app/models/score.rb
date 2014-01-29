class Score < ActiveRecord::Base
  belongs_to :student, dependent: :destroy
  belongs_to :test, dependent: :destroy
  validates :test, uniqueness: {scope: :student_id}, presence: true
  validates :student, presence: true
  validates :math, numericality: { greater_than_or_equal_to: 200, less_than_or_equal_to: 800 }
  validates :reading, numericality: { greater_than_or_equal_to: 200, less_than_or_equal_to: 800 }
  validates :writing, numericality: { greater_than_or_equal_to: 200, less_than_or_equal_to: 800 }
  

  def total
    math + reading + writing
  end
end
