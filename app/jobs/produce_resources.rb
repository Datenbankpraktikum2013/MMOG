#require "/app/models/planet"

class ProduceResources
	@queue = "workqueue"
	def self.perform(id)
		#raise "Hallo"
		@planet = Planet.find_by_id(id)
		@planet.update_resources
		@planet.save
	end

end
