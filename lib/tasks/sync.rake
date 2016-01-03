desc "This task is called by the Heroku scheduler add-on"
task :sync => :environment do
  puts "Syncing Members..."
  MarathonService.new.sync
  puts "done."
end

task :send_reminders => :environment do
  User.send_reminders
end
