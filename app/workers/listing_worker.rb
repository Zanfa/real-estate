require 'open-uri'

class ListingWorker
  @queue = :listing_queue

  def self.perform(url)
    listing_hash = ListingScraper.parse(open(url).read)

    Listing.where(kv_id: listing_hash[:kv_id]).first_or_initialize do |listing|
      listing.title = listing_hash[:title]
      listing.price = listing_hash[:price]
      listing.pictures = listing_hash[:pictures]
      saved = listing.save
    end
  end

end
