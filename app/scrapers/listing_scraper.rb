class ListingScraper

  def self.parse(html)
    doc = Nokogiri::HTML(html)

    pictures = []
    coords = {}

    # Find thumbnails and figure out large pictures
    doc.css('#imageList img').each do |thumbnail|
      src = thumbnail['src']

      cache_id_match = src.match(/^http:\/\/cache\.kv\.ee\/iv2\/obj\/1_1_(\d+)\.jpg$/)
      if cache_id_match
        pictures << "http://cache.kv.ee/iv2/obj/1_4_#{cache_id_match[1]}.jpg"
      # Not a picture, probably a map thubmnail
      else
        js = thumbnail['onclick']
        # If there are coordinates present in the onclick attr
        coords_match = js.match(/x=(\d+)&y=(\d+)/)
        if coords_match 
          x = coords_match[1].to_f
          y = coords_match[2].to_f
          coords = LambertEstConverter.to_lat_lng(x, y)
        end
      end
    end
    
    {
      title: doc.css('#obj_title h1').text.strip,
      price: doc.css('#obj_price_current .txt_red').text.gsub(/[^\d|\.]/, '').to_f,
      pictures: pictures,
      kv_id: doc.css('#obj_short_url').text.gsub(/[^\d]/, ''),
      coords: coords
    }
  end

end
