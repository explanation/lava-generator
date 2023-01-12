namespace :model do
  desc "Runs db:migrate and generates TypeScript interfaces for ActiveRecord models."
  task :migrate => :environment do
    Rake::Task["db:migrate"].invoke
    Rake::Task["typescript:migrate"].invoke
  end
end
