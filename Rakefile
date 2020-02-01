
require 'dotenv/tasks'
require_relative 'lib/ra_resale_checker'

desc "Task to run the Resale checker at hourly intervals. Enter desired ticket link"
task check_for_tickets: :dotenv do
RaResaleChecker.new("https://www.residentadvisor.net/events/1362733").run
end


