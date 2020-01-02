require 'twilio-ruby'
require 'nokogiri'    
require 'rest-client'

class RaResaleChecker

  def initialize(url)
    @url = url
  end

  def run
    send_text(@event_name) if resale_ticket_available?
  end

  def resale_ticket_available?
    parsed_doc = Nokogiri::HTML(RestClient.get(@url))
    @event_name = parsed_doc.search('#sectionHead h1').text
    parsed_doc.search('#buynow').present?
  end

  def send_text(event_name)
    client = Twilio::REST::Client.new(ENV['ACCOUNT_SID'], ENV['AUTH_TOKEN'])
    client.messages.create(
        body: "A resale ticket is now available for #{event_name}"
        to: ENV['MOBILE_NUM'],
        from: ENV['TWILIO_NUM'])
  end
end
