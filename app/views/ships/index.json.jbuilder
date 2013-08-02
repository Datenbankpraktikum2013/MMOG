json.array!(@ships) do |ship|
  json.extract! ship, :construction_time, :offense, :defense, :crystal_cost, :credit_cost, :ore_cost, :name, :velocity, :crew_capacity, :ressource_capacity, :fuel_capacity, :consumption
  json.url ship_url(ship, format: :json)
end
