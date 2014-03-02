require 'open-uri'

class SearchWorker
  @queue = :search_queue

  def self.perform
    search_params = [
      {county: 12, parish: 450}, # Tartu
      {county: 1, parish: 421} # Tallinn
    ]

    search_params.each do |search|
      response = open("http://www.kv.ee/?act=search.simple&page_size=10000&deal_type=2&county=#{search[:county]}&parish=#{search[:parish]}").read

      SearchScraper.parse(response).each do |url|
        Resque.enqueue(ListingWorker, url)
      end
    end

  end

end
