json.array!(@battlereports) do |battlereport|
  json.extract! battlereport, :defender_planet_id, :attacker_planet_id, :fightdate, :stolen_ore, :stolen_crystal, :stolen_space_cash, :defender_id, :attacker_id, :winner_id
  json.url battlereport_url(battlereport, format: :json)
end
