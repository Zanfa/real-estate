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
    listing[:kv_id].should eq '2186215'
  end

  it 'handles decimal prices' do
    html = File.open('spec/fixtures/listing_decimal.html').read
    listing = ListingScraper.parse(html)

    expect(listing[:price]).to eq 127.82
  end

end
