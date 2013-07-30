json.array!(@fleets) do |fleet|
  json.extract! fleet, :credit, :ressource_capacity, :ore, :crystal, :storage_factor, :velocity_factor, :offense, :defense, :user_id, :mission_id, :departure_time, :arrival_time, :start_planet, :target_planet
  json.url fleet_url(fleet, format: :json)
end
