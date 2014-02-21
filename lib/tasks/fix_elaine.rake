namespace :seed do
  desc "fix Elaine test score"
  task :fix_elaine => :envieronment do
    s = Student.find_by(first_name: "Elaine")
    t = Test.find(5)
    e_score = s.scores.find_by(test: t)
    e_score.update_attributes(reading: 370)
    e_score.save
  end
end