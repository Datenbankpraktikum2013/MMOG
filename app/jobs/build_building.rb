#require "/app/models/planet"

class BuildBuildings
	@queue = "buildqueue"
	#id_array should be [planet_id, building_id]
	def self.perform(id_array)
		#puts "Baue gebäude auf #{id_array[0]}"
		planet = Planet.find(id_array[0])
		#noch nicht implementiert stand 11:07
		planet.build_building(id_array[1])
	end
end
