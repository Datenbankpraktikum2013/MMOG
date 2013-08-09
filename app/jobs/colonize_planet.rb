#require "/app/models/fleet

class ColonizePlanet
	@queue = "move_fleets"
	def self.perform(fleet_id, planet_id)
		puts "#{Time.now} === Colonize Planet #{planet_id} by Fleet #{fleet_id}"
		Fleet.find(fleet_id).colonize(Planet.find(planet_id))
	end
end