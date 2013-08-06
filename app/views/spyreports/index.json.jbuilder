json.array!(@spyreports) do |spyreport|
  json.extract! spyreport, :energy, :space_cash, :population, :ore, :crystall
  json.url spyreport_url(spyreport, format: :json)
end
