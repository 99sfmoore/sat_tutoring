namespace :seed do
  desc "make catgory non-linear graphs have Topic \#8"
  task :adjust_non_linear_topic => :environment do
    non_linear = Category.find_by(name: "Non-Linear Graphs")
    topic_8 = Topic.find_by(number: 8)
    non_linear.update_attributes(topic: topic_8)
  end
end
