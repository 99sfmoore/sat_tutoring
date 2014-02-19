namespace :seed do
  desc "update Donnette HW Status"
  task :donnette_hw_status => :environment do
    s = Student.find_by(first_name: "Donnette")
    a = s.assignments.find_by(second_try: "pending")
    a.update_attributes(send_hints: true, second_try: "")
  end
end