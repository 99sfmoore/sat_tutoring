namespace :seed do
  desc "update Donnette HW Status"
  task :donnette_hw_status => :environment do
    s = Student.find_by(first_name: "Donnette")
    second = s.assignments.where("second_try = ?","pending")
    second.each do |a|
      a.update_attributes(send_hints: true, second_try: "")
    end
  end
end