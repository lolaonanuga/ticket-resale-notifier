desc "Task to run the Resale checker at 30 minute intervals. Enter desired ticket link"
task :check_for_tickets => :environment do
RaResaleChecker.new("https://www.residentadvisor.net/events/1352302").run
end

