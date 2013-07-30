json.array!(@missions) do |mission|
  json.extract! mission, :info_text
  json.url mission_url(mission, format: :json)
end
