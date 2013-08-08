#require "/app/models/fleet

class AddShip
	@queue = "add_ships"
	def self.perform(ship_id,planet_id,qid)
		# planet_id=ids["planet"]
		# ship_id=ids["ship"]
		# qid=ids["queue"]
		puts "#{Time.now} === Added Ship #{ship_id} to Planet #{planet_id}"
		Fleet.add_ship_to_planet(Ship.find(ship_id),Planet.find(planet_id))
		ShipBuildingQueue.find(qid).destroy
		#Fleet.find(fleet_id).add_ship(Ship.find(ship_id))
		
	end
end