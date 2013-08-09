#require "/app/models/fleet

class Colonize
	@queue = "move_fleets"
	def self.perform(fleet_id, planet_id)
		puts "#{Time.now} === Colonize Planet #{planet_id} by Fleet #{fleet_id}"
		Fleet.find(fleet_id).colonize(planet)
	end
end

class Transport
	@queue = "move_fleets"
	def self.perform(fleet_id, planet_id)
		puts "#{Time.now} === Transport to Planet #{planet_id} by Fleet #{fleet_id}"
		Fleet.find(fleet_id).transport(planet)
	end
end

class Travel
	@queue = "move_fleets"
	def self.perform(fleet_id, planet_id)
		puts "#{Time.now} === Travel to Planet #{planet_id} by Fleet #{fleet_id}"
		Fleet.find(fleet_id).travel(planet)
	end
end

class Attack
	@queue = "move_fleets"
	def self.perform(fleet_id, planet_id)
		puts "#{Time.now} === Attack Planet #{planet_id} by Fleet #{fleet_id}"
		Fleet.find(fleet_id).attack(planet)
	end
end