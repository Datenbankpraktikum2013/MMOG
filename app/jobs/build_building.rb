#require "/app/models/planet"

class BuildBuildings
	@queue = "buildqueue"
	#id_array should be [planet_id, building_id]
	def self.perform(id_array)
		planet = Planet.find(id_array[0])
		planet.build_building(id_array[1])
	end
end
