#require "/app/models/planet"

class ProduceResources
	@queue = "workqueue"
	def self.perform(planet_id)
		puts "Rohstoff produktion auf #{planet_id}"
		planet = Planet.find(planet_id)
		#noch nicht implementiert stand 11:07
		planet.update_ore
	end
end
