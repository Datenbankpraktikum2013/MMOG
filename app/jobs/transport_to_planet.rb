#require "/app/models/fleet

class TransportToPlanet
	@queue = "move_fleets"
	def self.perform(fleet_id, planet_id)
		puts "#{Time.now} === Transport to Planet #{planet_id} by Fleet #{fleet_id}"
		Fleet.find(fleet_id).transport(planet)
	end
end