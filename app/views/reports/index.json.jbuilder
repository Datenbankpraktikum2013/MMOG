json.array!(@reports) do |report|
  json.extract! report, :reportable_id, :defender_planet_id, :attacker_planet_id, :fightdate, :defender_id, :attacker_id, :read
  json.url report_url(report, format: :json)
end
