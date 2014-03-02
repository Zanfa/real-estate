require 'spec_helper'

describe LambertEstConverter do
  
  it 'convert to lat/lng' do
    result = LambertEstConverter.to_lat_lng(543996, 6588885)

    expect(result[:lat]).to eq 59.435516111116904
    expect(result[:lng]).to eq 24.775289392049288
  end
end
