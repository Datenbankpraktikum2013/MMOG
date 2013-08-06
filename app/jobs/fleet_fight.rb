#require "/app/models/fleet

class FleetFight
	@queue = "fleet_queue"
	def self.perform(fleet_id,planet_id)
		Fleet.find(fleet_id).fight(Planet.find(planet_id))
	end
end