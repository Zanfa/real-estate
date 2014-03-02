require 'spec_helper'

describe ListingWorker do

  let (:url) { 'http://www.test.com/listing.html' }
  let (:response) { 'response' }
  let (:listing_stub) { stub_request(:get, url).to_return(status: 200, body: response) }
  let (:listing_hash) {
      {
        title: 'Korter', 
        price: 100, 
        pictures: [],
        kv_id: '12345'
      }
 }

  before :each do 
    listing_stub
  end

  it 'creates a new database entry' do
    ListingScraper.should_receive(:parse).with(response) { listing_hash }
    
    ListingWorker.perform url
    Listing.all.count.should eq 1
    listing_stub.should have_been_made
  end

  it 'does not create duplicates' do
    ListingScraper.should_receive(:parse).with(response).twice { listing_hash }
    ListingWorker.perform url
    ListingWorker.perform url

    Listing.all.count.should eq 1
  end

end
