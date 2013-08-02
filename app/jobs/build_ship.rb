#require "/app/models/fleet

class AddShip
	@queue = "add_ships"
	def self.perform(fleet_id,ship_id)
		Fleet.find(fleet_id).add_ship(Ship.find(ship_id))
		puts "#{Time.now} === Added Ship #{ship_id} to Fleet #{fleet_id}"
	end
end