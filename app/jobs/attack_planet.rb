#require "/app/models/fleet

class Attack
	@queue = "move_fleets"
	def self.perform(fleet_id, planet_id)
		puts "#{Time.now} === Attack Planet #{planet_id} by Fleet #{fleet_id}"
		Fleet.find(fleet_id).attack(planet)
	end
end