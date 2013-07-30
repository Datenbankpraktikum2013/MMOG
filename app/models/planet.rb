require "resque"
require "models/workingqueues/buildBuildingqueue"
require "models/workingqueues/rostoffqueue"


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

  belongs_to :sunsystem
  has_many :buildings

  #grober entwurf
  def createBuildingjob(buildingtyp_id)
    Resque.enqueue(BuildBuildingjob, id_array(planet_id,buildingtyp_id))

  end

  def createRohstoffJob(buildingtyp_id)
    Resque.enqueue(RohstoffProduktionsjob, planet_id)

  end

  def getDistance(other)
    if other.is_a?Planet then

      dist1 = self.Sunsystem.getDistance(other.Sunsystem)
      if dist1 < 0 then
        return -1
      end

      if(dist1 == 0) then
        if self.id < other.id then
          dist2 = other.id - self.id
        else
          dist2 = self.id - other.id
        end
      else
        dist2 = ((self.id + other.id)^3)/((self.id - other.id)^2 + 1)
      end
      dist1 + dist2

    end
    -1
  end

end
