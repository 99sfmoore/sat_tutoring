class Segment < ActiveRecord::Base
  has_many :topics
  has_many :categories, through: :topics

  def self.all_test
    Segment.all.delete_if{|s| s.name == "Vocabulary"}
  end
end
