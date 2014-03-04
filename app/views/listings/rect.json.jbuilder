json.array!(@listings) do |listing|
  json.extract! listing, :id, :title, :pictures, :price
  json.coords do
    json.lat listing.coords.x
    json.lng listing.coords.y
  end
end
