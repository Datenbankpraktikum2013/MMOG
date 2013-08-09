#require "/app/models/fleet

class TravelToPlanet
	@queue = "move_fleets"
	def self.perform(fleet_id, planet_id)
		puts "#{Time.now} === Travel to Planet #{planet_id} by Fleet #{fleet_id}"
		Fleet.find(fleet_id).travel(Planet.find(planet_id))
	end
end