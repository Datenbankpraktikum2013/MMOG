json.array!(@shipfleets) do |shipfleet|
  json.extract! shipfleet, :ship_id, :fleet_id, :amount
  json.url shipfleet_url(shipfleet, format: :json)
end
