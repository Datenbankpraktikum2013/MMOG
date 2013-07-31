json.array!(@buildingtypes) do |buildingtype|
  json.extract! buildingtype, :name, :stufe, :produktion, :energieverbrauch
  json.url buildingtype_url(buildingtype, format: :json)
end
