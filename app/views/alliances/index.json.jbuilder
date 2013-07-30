json.array!(@alliances) do |alliance|
  json.extract! alliance, :name, :default_rank
  json.url alliance_url(alliance, format: :json)
end
