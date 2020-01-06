
require 'dotenv/tasks'
require_relative 'lib/ra_resale_checker'

desc "Task to run the Resale checker at 30 minute intervals. Enter desired ticket link"
task check_for_tickets: :dotenv do
RaResaleChecker.new("ticket link here").run
end


