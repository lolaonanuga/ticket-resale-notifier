require 'dotenv/load'
require 'twilio-ruby'
require 'nokogiri'    
require 'rest-client'
require 'byebug'
Dotenv.load('.env.local')

class RaResaleChecker

  def initialize(url)
    @url = url
  end

  def run
    if resale_ticket_available?
      send_text(@event_name)
    else
      puts 'no tickets available'
    end
  end

  def resale_ticket_available?
    parsed_doc = Nokogiri::HTML(RestClient.get(@url))
    @event_name = parsed_doc.search('#sectionHead h1').text
    parsed_doc.search('#buynow').any?
  end

  def send_text(event_name)

    client = Twilio::REST::Client.new(ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN'])
    client.messages.create(
        body: "A resale ticket is now available for #{event_name}",
        to: ENV['MOBILE_NUM'],
        from: ENV['TWILIO_NUM'])
  end
end
