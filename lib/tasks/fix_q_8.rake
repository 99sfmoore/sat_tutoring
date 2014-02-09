namespace :seed do
  desc "fix Section 8 Question 9 (and question 8) on PT #3"
  task :fix_q_8 => :environment do
    q = Question.find_by(section_id: 776, question_num: 8)
    c = Category.find_by(name: "Non-Linear Graphs")
    q.update_attributes(category: c)
    q = Question.find_by(section_id: 776, question_num: 9)
    c = Category.find_by(name: "Geometric Visualization")
    q.update_attributes(category: c) 
  end
end