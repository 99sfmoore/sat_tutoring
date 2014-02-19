namespace :seed do
  desc "update Donnette HW Status"
  task :donnette_hw_status => :environment do
    s = Student.find_by(first_name: "Donnette")
    second = s.second_try_homeworks.map{|hw| hw.assignment}
    second.each do |a|
      a.update_attributes(send_hints: true, second_try: "")
    end
  end
end