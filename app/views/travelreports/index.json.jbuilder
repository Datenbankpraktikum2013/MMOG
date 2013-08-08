json.array!(@travelreports) do |travelreport|
  json.extract! travelreport, :mode
  json.url travelreport_url(travelreport, format: :json)
end
