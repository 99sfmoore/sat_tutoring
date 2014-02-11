class RawScore < ActiveRecord::Base
  belongs_to :test
  belongs_to :student
end
