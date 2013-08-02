json.array!(@planets) do |planet|
  json.extract! planet, :z, :name, :special, :size, :ore, :maxore, :crystal, :maxcrystal, :energy, :maxenergy, :population, :maxpopulation
  json.url planet_url(planet, format: :json)
end
