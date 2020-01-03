# frozen_string_literal: true

require 'spec_helper'
require_relative '../lib/ra_resale_checker'

RSpec.describe 'RA Resale Checker' do

  context 'when a ticket is available' do
    response = File.read("spec/fixtures/files/response.html")
    let(:ra_checker) { RaResaleChecker.new("www.faketicketurl.com") }
    
    before do
      stub_request(:get, "www.faketicketurl.com")
        .to_return(status: 200, body: response , headers: {})
          
      stub_request(:post, "https://api.twilio.com/2010-04-01/Accounts/fakesid1234/Messages.json")
        .with(
          body: { 
            "Body"=> "A resale ticket is now available for Event ",
             "From"=>"+2222222",
              "To"=>"fakenum1234"
          },
          headers: {
            'Authorization'=>'Basic ZmFrZXNpZDEyMzQ6ZmFrZXRva2VuMTIzNA==',
          })
        .to_return(status: 200, body: "", headers: {})
      allow(ra_checker).to receive(:send_text)
      ra_checker.run
    end

    it 'sends a text message' do
      expect(ra_checker).to have_received(:send_text)
    end
  end

  context 'when a ticket is not available' do
    let(:ra_checker) { RaResaleChecker.new("www.faketicketurl.com") }
    before do
      stub_request(:get, "www.faketicketurl.com")
        .to_return(status: 200, body: "", headers: {})
      ra_checker.run
    end

    it 'does not send a text message' do
      expect(ra_checker).not_to receive(:send_text)
    end
  end
end
