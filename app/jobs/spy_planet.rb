#require "/app/models/fleet

class SpyPlanet
	@queue = "move_fleets"
	def self.perform(fleet_id, planet_id, own_spy_factor)
		puts "#{Time.now} === Spy Planet #{planet_id} by Fleet #{fleet_id}"
		Fleet.find(fleet_id).spy(own_spy_factor, Planet.find(planet_id))
	end
end