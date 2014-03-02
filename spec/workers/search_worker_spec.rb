require 'spec_helper'

describe SearchWorker do

  let (:tartu_response) { 'tartu_response' }
  let (:tallinn_response) { 'tallinn_response' }

  it 'should GET listings for Tartu and Tallinn' do

    # Set up all endpoints
    tartu_request = stub_request(:get, 'http://www.kv.ee/?act=search.simple&page_size=10000&deal_type=2&county=12&parish=450').to_return(status: 200, body: tartu_response)

    tallinn_request = stub_request(:get, 'http://www.kv.ee/?act=search.simple&page_size=10000&deal_type=2&county=1&parish=421').to_return(status: 200, body: tallinn_response)

    # Keep track of all requests for later
    request_stubs = [tartu_request, tallinn_request]

    SearchScraper.should_receive(:parse).with(tartu_response).once { ['http://www.test.com', 'http://www.test2.com'] }
    SearchScraper.should_receive(:parse).with(tallinn_response).once { ['http://www.test3.com'] }

    Resque.should_receive(:enqueue).with(ListingWorker, 'http://www.test.com')
    Resque.should_receive(:enqueue).with(ListingWorker, 'http://www.test2.com')
    Resque.should_receive(:enqueue).with(ListingWorker, 'http://www.test3.com')

    SearchWorker.perform

    request_stubs.each { |stub| stub.should have_been_made }

  end  

end
