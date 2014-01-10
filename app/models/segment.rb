class Segment < ActiveRecord::Base
  has_many :topics
  has_many :categories, through: :topics
end
