namespace :seed do
  desc "fix categories on PT4"
  task :fix_pt4 => :environment do
    q = Question.find_by(section_id: 784, question_num: 14)
    c = Category.find_by(name: "Data Analysis")
    q.update_attributes(category: c)
    q = Question.find_by(section_id: 783, question_num: 3)
    c = Category.find_by(name: "Permutations and Combinations")
    q.update_attributes(category: c)
    q = Question.find_by(section_id: 783, question_num: 7)
    c = Category.find_by(name: "Data Analysis")
    q.update_attributes(category: c)  
    q = Question.find_by(section_id: 783, question_num: 9)
    c = Category.find_by(name: "Complex Figures")
    q.update_attributes(category: c) 
    q = Question.find_by(section_id: 782, question_num: 2)
    c = Category.find_by(name: "Data Analysis")
    q.update_attributes(category: c)  
    q = Question.find_by(section_id: 779, question_num: 18)
    c = Category.find_by(name: "Global")
    q.update_attributes(category: c)    
  end
end