class Planet < ActiveRecord::Base


  belongs_to :sunsystem
  has_many :buildings

  def update_ore()
    if (self.eisenerz + 20) < self.maxeisenerz then
      self.eisenerz += 20
    else
      self.eisenerz = self.maxeisenerz
    end
  end

  #grober entwurf
  def createBuildingJob(buildingtyp_id)
    Resque.enqueue(BuildBuildingjob, id_array(planet_id,buildingtyp_id))
  end

  def createResourcesJob
  	puts "Planeten ID #{self.id}"
	Resque.enqueue(ProduceResources, self.id)

 	end

  def getDistance(other)
    if other.is_a?Planet then

      dist1 = self.Sunsystem.getDistance(other.Sunsystem)
      if dist1 < 0 then
        return -1
      end

      if(dist1 == 0) then
        if self.z < other.z then
          dist2 = other.z - self.z
        else
          dist2 = self.z - other.z
        end
      else
        dist2 = ((self.z + other.z)^3)/((self.z - other.z)^2 + 1)
      end
      dist1 + dist2
  
    #von usn geändert wenn quatswch richtig machen
    else  
      return -1
    # hier auchs 
    end  
  end

end
