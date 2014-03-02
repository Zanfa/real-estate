json.array!(@listings) do |listing|
  json.extract! listing, :id, :title, :pictures, :price
  json.url listing_url(listing, format: :json)
end
