#require "/app/models/fleet

class AttackPlanet
	@queue = "move_fleets"
	def self.perform(fleet_id, planet_id)
		puts "#{Time.now} === Attack Planet #{planet_id} by Fleet #{fleet_id}"
		Fleet.find(fleet_id).attack(Planet.find(planet_id))
	end
end