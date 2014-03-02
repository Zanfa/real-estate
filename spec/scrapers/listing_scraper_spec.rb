require 'spec_helper'

describe ListingScraper do

  it 'returns a valid listing hash from html' do
    html = File.open('spec/fixtures/listing.html').read
    listing = ListingScraper.parse(html)

    listing[:title].should eq 'Anda üürile korter, 2 tuba - Tartumaa, Tartu, Kesklinn, Turu'
    listing[:price].should eq 275
    listing[:pictures].count.should eq 10
    listing[:pictures].first.should eq 'http://cache.kv.ee/iv2/obj/1_4_37026443.jpg'
    listing[:pictures].last.should eq 'http://cache.kv.ee/iv2/obj/1_4_37026453.jpg'
    expect(listing[:coords][:lat]).to eq 58.37508163737743
    expect(listing[:coords][:lng]).to eq 26.73310669898496
    listing[:kv_id].should eq '2186215'
  end

  it 'handles decimal prices' do
    html = File.open('spec/fixtures/listing_decimal.html').read
    listing = ListingScraper.parse(html)

    expect(listing[:price]).to eq 127.82
  end

  it 'works without a map being in the listing' do
    html = File.open('spec/fixtures/listing_no_map.html').read
    listing = ListingScraper.parse(html)

    expect(listing[:coords]).to eq({})
  end

end
