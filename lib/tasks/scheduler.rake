require 'rake'

desc "This task is called by the Heroku scheduler add-on"

task :update_sunsets => :environment do
  puts "Hello"
end