require "/app/models/planet"

class RohstoffProduktionsjob
	@queue = workqueue
	def.selfperform(planet_id)
		puts "Rohstoff produktion auf #{planet_id}"
		planet = Planet.find(planet_id)
		#noch nicht implementiert stand 11:07
		planet.produziere()
	end
end
