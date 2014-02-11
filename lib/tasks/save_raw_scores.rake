namespace :seed do
  desc "save raw scores in db"
  task :save_raw => :environment do
    m = Segment.find_by(name: "Math")
    r = Segment.find_by(name: "Reading")
    w = Segment.find_by(name: "Writing")
    Student.all.each do |s|
      Test.kaplan.each do |t|
        if s.took?(t)
          RawScore.create(test: t, student: s, math: s.my_raw_score(t,m)[:score],
                           reading: s.my_raw_score(t,r)[:score],
                           writing: s.my_raw_score(t,w)[:score])
        end
      end
    end
  end
end