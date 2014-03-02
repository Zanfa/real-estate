class ListingScraper

  def self.parse(html)
    doc = Nokogiri::HTML(html)

    pictures = []

    # Find thumbnails and figure out large pictures
    doc.css('#imageList img').each do |thumbnail|
      src = thumbnail['src']
      cache_id_match = src.match(/^http:\/\/cache\.kv\.ee\/iv2\/obj\/1_1_(\d+)\.jpg$/)
      if cache_id_match
        pictures << "http://cache.kv.ee/iv2/obj/1_4_#{cache_id_match[1]}.jpg"
      end
    end
    
    {
      title: doc.css('#obj_title h1').text.strip,
      price: doc.css('#obj_price_current .txt_red').text.gsub(/[^\d|\.]/, '').to_f,
      pictures: pictures,
      kv_id: doc.css('#obj_short_url').text.gsub(/[^\d]/, '')
    }
  end

end
