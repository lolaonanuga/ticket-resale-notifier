# frozen_string_literal: true

require 'spec_helper'

RSpec.describe 'RA Resale Checker' do
  let(:checker) { RaResaleChecker.new }


  context 'when a ticket is available' do
    before do
      stub_request(:get, "www.faketicketurl.com")
        .to_return(status: 200, body: file_fixture('cve_description.html')
          .read, headers: {})
          RaResaleChecker.new().run

    end

    it 'sends a text message' do
      
    end
  end

  context 'when a ticket is not available' do
    before do
      stub_request(:get, "www.faketicketurl.com")
        .to_return(status: 200, body: file_fixture('cve_description.html')
          .read, headers: {})
      
      RaResaleChecker.new().run


    end

    it 'does not send a text message' do
    
    end
  end
end
