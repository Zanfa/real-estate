require 'spec_helper'

describe Listing do

  it 'preserves coords' do
    Listing.create(coords: {lat: 58.37508163737743, lng: 26.73310669898496})

    first = Listing.first
    expect(first.coords.x).to eq 58.37508163737743
    expect(first.coords.y).to eq 26.733106698984965
  end

end
