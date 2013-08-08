#require "/app/models/fleet

class SpyPlanet
	@queue = "move_fleets"
	def self.perform(fleet_id, planet_id, own_spy_factor)
		puts "#{Time.now} === Spy Planet #{planet_id} by Fleet #{fleet_id}"
		f = Fleet.find(fleet_id)
		p = Planet.find(planet_id)
		f.spy(own_spy_factor, p)
	end
end