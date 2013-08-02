#require "/app/models/planet"

class ProduceResources
	@queue = "workqueue"
	def self.perform(id)
		#puts "Rohstoff produktion auf #{id}"
		@planet = Planet.find_by_id(id)
		#puts "der Planet hat vor erhöhen #{@planet.ore}"
		@planet.update_resources
		#puts "der Planet hat nach erhöhen #{@planet.ore}"
		@planet.save
	end

end
