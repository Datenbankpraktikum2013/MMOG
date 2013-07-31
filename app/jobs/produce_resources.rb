#require "/app/models/planet"

class ProduceResources
	@queue = "workqueue"
	def self.perform(id)
		puts "Rohstoff produktion auf #{id}"
		sleep 1
		@planet = Planet.find_by_id(id)
		puts "der Planet hat vor erhöhren #{@planet.eisenerz}"

		#noch nicht implementiert stand 11:07
		@planet.update_ore
		puts "der Planet hat nach erhöhren #{@planet.eisenerz}"
		@planet.save!
	end
end
