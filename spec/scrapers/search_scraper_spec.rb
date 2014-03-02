require 'spec_helper'

describe SearchScraper do

  it 'scrapes individual listing URLs from search to an array' do
    html = File.open('spec/fixtures/search.html').read
    listing_urls = SearchScraper.parse(html)

    listing_urls.count.should eq 10
    listing_urls.first.should eq 'http://www.kv.ee/soodsalt-valja-uurida-2-toaline-korter-tudengitele-2186215.html'
    listing_urls.last.should eq 'http://www.kv.ee/uurile-anda-2toaline-korter-korter-on-osaliselt-mo-2297956.html'
  end

end
