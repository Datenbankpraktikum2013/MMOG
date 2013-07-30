require "resque"
require "models/workingqueues/buildBuildingqueue"
require "models/workingqueues/rostoffqueue"

class Planet < ActiveRecord::Base
	
	#grober entwurf
	def createBuildingjob(buildingtyp_id)
		Resque.enqueue(BuildBuildingjob, id_array(planet_id,buildingtyp_id))

	end

	def createRohstoffJob(buildingtyp_id)
		Resque.enqueue(RohstoffProduktionsjob, planet_id)

	end
end
