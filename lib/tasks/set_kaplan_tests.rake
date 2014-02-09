namespace :seed do
  desc "set official Kaplan Practice Tests"
  task :set_practice_tests => :environment do
    Test.find([3,5,10,11]).each do |t|
      t.update_attributes(kaplan: true, assignable: false)
    end
  end
end