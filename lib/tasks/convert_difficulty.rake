namespace :seed do
  desc "give difficulty integer values for ordering of questions"
  task :difficulty_integers => :environment do
    Question.all(:conditions => {:difficulty_num => nil}).each do |q|
      if q.difficulty == "Low"
        q.difficulty_num = 1
      elsif q.difficulty == "Medium"
        q.difficulty_num = 3
      elsif q.difficulty == "High"
        q.difficulty_num = 5
      end
      q.save
    end
  end
end