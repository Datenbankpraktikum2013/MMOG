json.array!(@planets) do |planet|
  json.extract! planet, :z, :name, :spezialisierung, :groesse, :eisenerz, :maxeisenerz, :kristalle, :maxkristalle, :energie, :maxenergie, :einwohner, :maxeinwohner
  json.url planet_url(planet, format: :json)
end
