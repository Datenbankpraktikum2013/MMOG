class Planet < ActiveRecord::Base


  belongs_to :sunsystem
  has_many :buildings
  has_many :fleets
  def getProductionFactorOf(type)
    # TODO Calculate the factor of productionspeed
    return 1
  end

  def getBuildingFactorOf(type)
    # TODO Calculate the factor of buildingspeed
    return 1
  end

  def update_ore
    ammount = 20
    #f = getProductionFactorOf(:ore)
    f = 1
    if ammount.integer? then
      ammount = f * ammount
      if (self.ore + ammount) < self.maxore then
        self.ore += ammount
      else
        self.ore = self.maxore
      end
      #Resque.enqueue_in(1.minute, ProduceResources, self.id)
    end
    self.createProductionJob
  end

  #grober entwurf
  def createBuildingJob(buildingtyp_id)
    Resque.enqueue(BuildBuildingjob, id_array(planet_id,buildingtyp_id))
  end

  def createProductionJob()
    puts "Planeten ID #{self.id}"
    #Resque.enqueue(ProduceResources, self.id)
    Resque.enqueue_in(1.minute, ProduceResources, self.id)
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
    else
      -1
    end
  end

end
