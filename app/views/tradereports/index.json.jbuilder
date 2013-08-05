json.array!(@tradereports) do |tradereport|
  json.extract! tradereport, :ore, :crystal, :space_cash
  json.url tradereport_url(tradereport, format: :json)
end
