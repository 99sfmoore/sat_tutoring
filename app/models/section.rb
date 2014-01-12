class Section < ActiveRecord::Base
  # belongs_to :category  # this was old category
  belongs_to :segment
  belongs_to :test
  has_many :questions, dependent: :destroy
  has_and_belongs_to_many :lesson_plans
  has_and_belongs_to_many :homeworks
  belongs_to :topic


  # add question numbers !!!!!!!
  def self.make_from_file(filename) 
    CSV.foreach(filename.path, headers: true) do |row|
      section_hash = row.to_hash
      section_hash["segment_id"] = Segment.find_by(name: section_hash["segment_name"].strip).id
      section_hash["topic_id"] = Topic.find_by(number: section_hash["topic_number"].strip.to_i).id
      diff = section_hash["difficulty"].strip
      new_section = Section.create(section_hash.except("segment_name","topic_number","difficulty"))
      new_section.num_of_questions.times do |n|
        new_section.questions.build(difficulty: diff)
      end
      new_section.save
    end
  end

  def page_range
    if start_page == end_page
      return "#{start_page}"
    else
      return "#{start_page} - #{end_page}"
    end
  end

  def difficulty
    if start_page
      questions.first.difficulty unless questions.first.nil?
    else
      "N/A"
    end
  end


  def name
    if test
      "#{test.name} - Section \##{section_num} - #{segment.name}"
    else
      "Topic\##{topic.number} - #{topic.name} - #{self.difficulty} #{segment.name}"
    end
  end

  

end
