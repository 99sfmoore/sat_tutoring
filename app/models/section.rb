class Section < ActiveRecord::Base
  belongs_to :segment
  belongs_to :test
  has_many :questions, dependent: :destroy, order: 'question_num ASC'
  has_and_belongs_to_many :lesson_plans
  has_and_belongs_to_many :homeworks
  belongs_to :topic


  def self.make_from_file(filename) 
    CSV.foreach(filename.path, headers: true) do |row|
      section_hash = row.to_hash
      section_hash["segment_id"] = Segment.find_by(name: section_hash["segment_name"].strip).id
      section_hash["topic_id"] = Topic.find_by(number: section_hash["topic_number"].strip.to_i).id
      diff = section_hash["difficulty"].strip
      first = section_hash["first_q_num"].to_i
      last = section_hash["last_q_num"].to_i
      new_section = Section.create(section_hash.except("segment_name","topic_number","difficulty","first_q_num","last_q_num"))
      (first..last).each do |n|
        new_section.questions.build(question_num: n, difficulty: diff)
      end
      new_section.update_attributes(assignable: true)
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
      questions.first.difficulty
    else
      "N/A"
    end
  end


  def name
    if test
      "#{test.name} - Section \##{section_num} - #{segment.name}"
    else
      "Topic \##{topic.number} - #{topic.name} - pg. #{self.page_range} - #{self.difficulty}"
    end
  end

  def name_for_students
    if test
      "#{test.name} - Section \##{section_num} - #{segment.name}"
    else
      "Kaplan - pg. #{self.page_range}"
    end
  end

  

end
