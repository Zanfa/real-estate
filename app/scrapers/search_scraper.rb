class SearchScraper 

  def self.parse(html)

    doc = Nokogiri::HTML(html)
    listing_urls = []

    doc.css('.s_res_obj_container .s_res_top_title_column a').each do |link|
      href = link['href']
      href_match = href.match(/^(.+)\?/)
      if href_match
        listing_urls << href_match[1]
      end
    end

    listing_urls
  end

end
