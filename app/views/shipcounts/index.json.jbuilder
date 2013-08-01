json.array!(@shipcounts) do |shipcount|
  json.extract! shipcount, :battlereport_id, :ship_id, :amount, :shipowner_time_type
  json.url shipcount_url(shipcount, format: :json)
end
