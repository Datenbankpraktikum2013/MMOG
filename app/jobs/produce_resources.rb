#require "/app/models/planet"

class ProduceResources
	@queue = "workqueue"
	def self.perform(id)
		puts "Rohstoff produktion auf #{id}"
		sleep 1
		@planet = Planet.find_by_id(id)
		puts "der Planet hat vor erhöhen #{@planet.ore}"

		#noch nicht implementiert stand 11:07
		@planet.updateResources
		@planet.save
		puts "der Planet hat nach erhöhen #{@planet.ore}"
	end
end
