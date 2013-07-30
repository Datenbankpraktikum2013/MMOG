json.array!(@buildings) do |building|
  json.extract! building, :id, :typeid, :letzteaktion
  json.url building_url(building, format: :json)
end
