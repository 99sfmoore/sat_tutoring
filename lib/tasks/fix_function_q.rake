namespace :seed do
  desc "fix Section 7 Question 7 on PT #3"
  task :fix_function_q => :environment do
    q = Question.find_by(section_id: 775, question_num: 7)
    c = Category.find_by(name: "Function")
    q.update_attributes(category: c)
  end
end