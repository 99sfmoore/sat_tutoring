namespace :seed do
  desc "make CB Web 2014 assignable"
  task :cb_web => :environment do
    t = Test.find_by(name: "CB Website 2014")
    t.update_attributes(assignable: true)
    t.sections.each do |s|
      s.update_attributes(assignable: true)
    end
  end
end