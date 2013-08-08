#require "/app/models/fleet

class ReturnToOrigin
	@queue = "move_fleets"
	def self.perform(fleet_id)
		fleet = Fleet.find(fleet_id)
		puts "#{Time.now} === Fleet #{fleet_id} returns to Planet #{fleet.origin_planet.id}"
		
		home_fleet = Fleet.get_home_fleet(fleet.origin_planet)
		home_fleet.merge_fleet(fleet)
	end
end