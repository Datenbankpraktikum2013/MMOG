require "/app/models/planet"

class ErzProduktionsjob
	@queue = workqueue
	def.selfperform(planet_id)
		puts "Erzproduktion auf #{planet_id}"
		planet = Planet.find(planet_id)
		planet.produziere()
	end
end
