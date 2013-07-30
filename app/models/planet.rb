#require "resque"
#require "app/controllers/workingqueues/buildBuildingqueue"
#require "app/controllers/workingqueues/rohstoffqueue"


class Planet < ActiveRecord::Base

	def update_ore
		if (ore + 20) < max_ore
			ore += 20
		else ore = max_ore	
		end
	end

	#grober entwurf
	def createBuildingjob(buildingtyp_id)
		Resque.enqueue(BuildBuildingjob, id_array(planet_id,buildingtyp_id))

	end

	def createRohstoffJob(buildingtyp_id)
		Resque.enqueue(RohstoffProduktionsjob, planet_id)

	end
end
