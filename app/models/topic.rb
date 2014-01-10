class Topic < ActiveRecord::Base
  belongs_to :segment
  has_many :categories
  has_many :questions, through: :categories
end
