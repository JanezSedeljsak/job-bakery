json.extract! location, :id, :title, :postcode, :created_at, :updated_at
json.url location_url(location, format: :json)
