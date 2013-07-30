#require "/app/models/planet"

class ProduceResources
	@queue = "workqueue"
	def self.perform(id)
		puts "Rohstoff produktion auf #{id}"
		#sleep 5
		#planet = Planet.find(id)
		#noch nicht implementiert stand 11:07
		#planet.update_ore
	end
end
