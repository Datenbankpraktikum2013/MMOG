#require "/app/models/fleet

class MoveFleet
	@queue = "move_fleets"
	def self.perform(fleet_id,planet_id)
		f=Fleet.find(fleet_id)
		p=Planet.find(planet_id)
		# f=Fleet.find(fleet_id)
		# puts f
		# p=Planet.find(planet_id)
		# puts p
		# f.target_planet=p
		# f.save
		f.start_planet=p
		f.save

		puts "#{Time.now} === Moved Fleet #{f.id} to Planet #{p.id}"
	end
end
