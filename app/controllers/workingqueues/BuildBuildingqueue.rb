require "/app/models/planet"

class BuildBuildingjob
	@queue = workqueue
	#id_array should be [planet_id, building_id]
	def.selfperform(id_array)
		puts "Baue gebäude auf #{id_array[0]}"
		planet = Planet.find(id_array[0])
		#noch nicht implementiert stand 11:07
		planet.build(id_array[1])
	end
end
