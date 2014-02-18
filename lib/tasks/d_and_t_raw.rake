namespace :seed do
  desc "calc raw for Danika & Tiffany"
  task :d_and_t_raw => :environment do
    t = Test.find(10)
    ["Danika","Tiffany"].each do |n|
      s = Student.find_by(first_name: n)
      s.raw_scores.build(test: t, 
                        math: s.my_raw_score(test, Segment.find_by(name: "Math"))[:score],
                        reading: s.my_raw_score(test, Segment.find_by(name: "Reading"))[:score],
                        writing: s.my_raw_score(test, Segment.find_by(name: "Writing"))[:score])
      s.save
    end
  end
end