class Section < ActiveRecord::Base
  # belongs_to :category  # this was old category
  belongs_to :segment
  belongs_to :test
  has_many :questions, dependent: :destroy
  has_and_belongs_to_many :lesson_plans
  has_and_belongs_to_many :homeworks

  def self.make_from_file(filename)
    CSV.foreach(filename.path, headers: true) do |row|
      section_hash = row.to_hash
      section_hash["category_id"] = Category.find_by(topic: section_hash["topic"]).id
      diff = section_hash["difficulty"]
      new_section = Section.create(section_hash.except("topic","difficulty"))
      new_section.num_of_questions.times do |n|
        new_section.questions.build(difficulty: diff)
      end
    end
  end

  def page_range
    if start_page == end_page
      return "#{start_page}"
    else
      return "#{start_page} - #{end_page}"
    end
  end


  def name
    # "#{Category.find(category_id).topic_name}, pg #{page_range}" if category_id
    "hi"
  end


  # def segment
  #   category.segment
  # end
end
