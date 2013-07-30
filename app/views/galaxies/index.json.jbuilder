json.array!(@galaxies) do |galaxy|
  json.extract! galaxy, :x, :name
  json.url galaxy_url(galaxy, format: :json)
end
