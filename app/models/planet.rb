#require "resque"
#require "app/controllers/workingqueues/buildBuildingqueue"
#require "app/controllers/workingqueues/rohstoffqueue"


class Planet < ActiveRecord::Base

	def update_ore
		if ((self.eisenerz + 20) < self.maxeisenerz)
			self.eisenerz = self.eisenerz + 20
		else self.eisenerz = self.maxeisenerz	
		end
	end

	#grober entwurf
	def createBuildingjob(buildingtyp_id)
		Resque.enqueue(BuildBuildingjob, id_array(planet_id,buildingtyp_id))

	end

	def createRohstoffJob
		puts "Planeten ID #{self.id}"
		Resque.enqueue(ProduceResources, self.id)


	end
end
